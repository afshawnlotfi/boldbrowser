//
//  TabManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit

@objc protocol TabManagerDelegate{
    
    func tabManager(_ tabManager : TabManager, didAddTab tab: Tab , atIndex : Int)
    func tabManager(_ tabManager : TabManager, didRemoveTab tab: Tab, atIndex : Int)
    func tabManager(_ tabManager : TabManager, didSelectTab tab: Tab, atIndex : Int)

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
            let savedTabDefaults = SavedTabDefaults(startIndex: tabs.count)
            savedTab = storageManager.addObject(from: savedTabDefaults) as! SavedTab
        }else{
            savedTab = restoreFrom!
        }
        
        configureTab(tab: tab, savedTab: savedTab)
        
        if atIndex == nil{
            let tabIndex = tabs.count
            tabs.append(tab)
            tabManagerDelegates.forEach{$0.tabManager(self, didAddTab: tab, atIndex : tabIndex); $0.tabManager(self, didSelectTab: tab, atIndex : tabIndex)}
        }
        

    }
    
    /// Updates tab position in storage and in "tabs"
    ///
    /// - Parameters:
    ///   - current: current index
    ///   - final: final index
    func updateIndecies(current : Int , final : Int){
        //If tab webview is loaded update its observer index stored in tag used to index it in "observeValue"
        let currentTab = tabs[current]
        tabs.remove(at: current)
        tabs.insert(currentTab, at: final)
        for (index,tab) in tabs.enumerated(){
            tab.webView?.tag = index
        }
//        self.storageManager.updateIndecies(current: current, final: final)
        
    }
    

    
    /// Configure Tab
    ///
    /// - Parameters:
    ///   - tab: Tab to configure
    ///   - savedTab: Saved Tab to restore from
    func configureTab(tab : Tab, savedTab : SavedTab){
        tab.lastTitle = savedTab.title
        print(savedTab.index)
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
            tab.webView?.addObserver(self, forKeyPath: $0, options: .new, context: nil)
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
        if let webView = object as? TabWebView{
            let index = webView.tag
            let tab = tabs[index]
            let savedTab = (storageManager.dataObjects as! [SavedTab])[index]
            let newValue = change?[NSKeyValueChangeKey(rawValue: "new")]
            if let key = keyPath{
                switch key {
                case KVOConstants.estimatedProgress:
                    webView.progressBarUpdated()
                case KVOConstants.title:
                    if let title = newValue as? String{
                        storageManager.updateObject(updatedValues: [KVOConstants.title:title], object: savedTab)
                        tab.tabDelegate?.tab(tab, didUpdateTitle: title, atIndex: index)
                    }

                case KVOConstants.URL:
                    break
                case KVOConstants.faviconURL:
                    if let faviconURL = newValue as? String{
                        storageManager.updateObject(updatedValues: [KVOConstants.faviconURL:faviconURL], object: savedTab)
                        let favicon = FaviconManager.retrieveFavicon(forUrl: faviconURL)
                        tab.favicon = favicon
                        tab.tabDelegate?.tab(tab, didUpdateFavicon: favicon, atIndex: index)
                    }
                case KVOConstants.loading:
                    if let isLoading = newValue as? Bool{
                        if isLoading == false{
                            tab.tabDelegate?.tab(tab, didFinishLoading: index)
                            tab.tabSession?.updateSession(tab: tab)
                            storageManager.updateObject(updatedValues: ["sessionData" : tab.tabSession?.data ?? TabSession.defaultData], object: savedTab)
                        }
                    }
                default:
                    break
                }
            }
        }
        
    }
}
