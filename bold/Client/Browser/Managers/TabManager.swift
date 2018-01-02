//
//  TabManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit

protocol TabManagerDelegate{
    
    func tabManager(_ tabManager : TabManager, didAddTab atIndex : IndexPath, tab: Tab)
    func tabManager(_ tabManager : TabManager, didRemoveTab atIndex : IndexPath, tab: Tab)
    func tabManager(_ tabManager : TabManager, didSelectTab atIndex : IndexPath, tab: Tab)
    func tabManager(_ tabManager : TabManager, didFinishLoading tab: Tab)
    func tabManager(_ tabManager : TabManager, didUpdateTitle atIndex : IndexPath, title : String)
    func tabManager(_ tabManager : TabManager, didUpdateFavicon atIndex : IndexPath, favicon : Favicon)

}



class TabManager:NSObject{
    
     var tabs:[Tab] = []
    private var storageManager = StorageManager<SavedTab>()
    private(set) var tabScriptManager = TabScriptManager()
    var tabManagerDelegates = [TabManagerDelegate]()
    
    override init() {
        super.init()
        
    }
    
    
    /// Adds tab at specified index with cofniguration
    ///
    /// - Parameters:
    ///   - atIndex: index to put tab
    ///   - configuration: configuration of webview
    ///   - restoreFrom: saved tab to restore new tab from
    func addTab(atIndex : Int? = nil, configuration : WKWebViewConfiguration? = nil, restoreFrom: SavedTab? = nil){
        var savedTab:SavedTab
        let configuration: WKWebViewConfiguration = configuration ?? WKWebViewConfiguration()
        let tab = Tab(configuration: configuration)
        
        if restoreFrom == nil{
            let savedTabDefaults = SavedTabDefaults()
            savedTab = storageManager.addObject(from: savedTabDefaults) as! SavedTab
        }else{
            savedTab = restoreFrom!
        }
        
        tab.lastTitle = savedTab.title
        if let faviconURL = (savedTab.faviconURL){
            tab.favicon =  FaviconManager.retrieveFavicon(forUrl: faviconURL)
        }
        tab.tabSession = TabSession(data: savedTab.sessionData! as Data)

        
        if atIndex == nil{
            tabs.append(tab)
            let tabIndex = IndexPath(item: tabs.count, section: 0)
            tabManagerDelegates.forEach{$0.tabManager(self, didAddTab: tabIndex, tab:tab); $0.tabManager(self, didSelectTab: tabIndex, tab:tab)}
        }
        

    }
    

    
    /// Configure Tab
    ///
    /// - Parameters:
    ///   - tab: Tab to configure
    ///   - savedTab: Saved Tab to restore from
    func configureTab(tab : Tab, savedTab : SavedTab){
        tab.lastTitle = savedTab.title
        if let faviconURL = (savedTab.faviconURL){
            tab.favicon =  FaviconManager.retrieveFavicon(forUrl: faviconURL)
        }
        tab.tabSession = TabSession(data: savedTab.sessionData! as Data)
    
    }

    /// Adds KVO observers to tabs
    ///
    /// - Parameters:
    ///   - tab: Tabs you want to add observers
    ///   - observerKeys: Observer Keys
    func addObserver(tab : Tab, observerKeys : [String]){
        observerKeys.forEach{
            tab.webView?.addObserver(self, forKeyPath: $0, options: [.new,.old], context: nil)
        }
    }
    
    
    /// Adds scripts to tabs
    ///
    /// - Parameters:
    ///   - tab: Tabs you want to add scripts
    ///   - tabScripts: Scripts you want to inject
    func addTabPluginScripts(tab : Tab, tabScripts : [TabPluginScript]){
        tabScripts.forEach{
            tabScriptManager.addTabScript(tabScript: $0, atTab: tab)
        }
    }
    
    
    /// Restores All Tabs from Saved Tabs
    func restoreTabs(){
        var savedTabs = storageManager.fetchObjects(fromDisk: true) as! [SavedTab]

        if savedTabs.count == 0{
            self.addTab(atIndex: nil, configuration: nil, restoreFrom: nil)
            //Updates from Cached Saved Tabs
            savedTabs = storageManager.fetchObjects(fromDisk: false) as! [SavedTab]

        }else{
            for savedTab in savedTabs{
                self.addTab(atIndex: nil, configuration: nil, restoreFrom: savedTab)
            }
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let webview = object as? TabWebView{
            if let key = keyPath{
                switch key {
                case KVOConstants.estimatedProgress:
                    webview.progressBarUpdated()
                case KVOConstants.title:
                    if let title = change?[NSKeyValueChangeKey(rawValue: "new")] as? String{
                        storageManager.updateObject(updatedValues: [KVOConstants.title:title], object: (storageManager.dataObjects as! [SavedTab])[webview.tag])
                        tabManagerDelegates.forEach{$0.tabManager(self, didUpdateTitle: IndexPath(row: webview.tag, section: 0) , title: title)}
                    }

                case KVOConstants.URL:
                    if let currentURL = change?[NSKeyValueChangeKey(rawValue: "new")] as? URL{
                        if let oldURL = change?[NSKeyValueChangeKey(rawValue: "old")] as? URL{
                            let backList = webview.backForwardList.backList.map{$0.url}
                            let forwardList = webview.backForwardList.forwardList.map{$0.url}
                            tabs[webview.tag].tabSession?.updateSession(urls: backList + [oldURL, currentURL] + forwardList, currentPage: backList.count + 1)
                            storageManager.updateObject(updatedValues: [ "sessionData" : tabs[webview.tag].tabSession?.data ?? TabSession.defaultData], object: (storageManager.dataObjects as! [SavedTab])[webview.tag])
                        }
                    }
                case KVOConstants.faviconURL:
                    if let faviconURL = change?[NSKeyValueChangeKey(rawValue: "new")] as? String{
                        
                        storageManager.updateObject(updatedValues: [KVOConstants.faviconURL:faviconURL], object: (storageManager.dataObjects as! [SavedTab])[webview.tag])
                        tabs[webview.tag].favicon = FaviconManager.retrieveFavicon(forUrl: faviconURL)
                        tabManagerDelegates.forEach{$0.tabManager(self, didUpdateFavicon: IndexPath(row: webview.tag, section: 0), favicon: tabs[webview.tag].favicon!)}
                    }
                case KVOConstants.loading:
                    if let isLoading = change?[NSKeyValueChangeKey(rawValue: "new")] as? Bool{
                        print(isLoading)
                        if isLoading == false{
                            tabManagerDelegates.forEach{$0.tabManager(self, didFinishLoading:  tabs[webview.tag])}
                        }
                    }
                default:
                    break
                }
            }
        }
        
    }
}
