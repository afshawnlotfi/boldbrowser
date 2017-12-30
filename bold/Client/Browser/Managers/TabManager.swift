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
    
    func tabManager(didAddTab atIndex : IndexPath, tab: Tab)
    func tabManager(didRemoveTab atIndex : IndexPath, tab: Tab)
    func tabManager(didSelectTab atIndex : IndexPath, tab: Tab)
    func tabManager(didUpdateTitle atIndex : IndexPath, tab : Tab)


}


class TabManager:NSObject{
    
    private(set) var tabs:[Tab] = []
    private var storageManager = StorageManager<SavedTab>()
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
        
        tab.tabSession = TabSession(data: savedTab.sessionData! as Data)
        if atIndex == nil{
            tabs.append(tab)
            let tabIndex = IndexPath(item: tabs.count, section: 1)
            tabManagerDelegates.forEach{$0.tabManager(didAddTab: tabIndex, tab:tab); $0.tabManager(didSelectTab: tabIndex, tab:tab)}
        }
        
    }
    
    func storeChanges(atIndex : Int){
        
        
        
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
    func addTabPluginScripts(tab : Tab, tabScripts : [ITabPluginScript]){
        tabScripts.forEach{
            tab.tabScriptManager.addTabScript(tabScript: $0, atTab: tab)
        }
    }
    
    
    /// Restores All Tabs from Saved Tabs
    func restoreTabs(){
        var savedTabs:[SavedTab] = storageManager.fetchObjects(fromDisk: true) as! [SavedTab]
        
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
                case BrowserStrings.EstimatedProgressObserver:
                    webview.progressBarUpdated()
                case BrowserStrings.TitleObserver:
                    tabManagerDelegates.forEach{$0.tabManager(didUpdateTitle: IndexPath(row: webview.tag, section: 0) , tab: tabs[webview.tag])}
                case BrowserStrings.URLObserver:
                    break
                default:
                    break
                }
            }
        }
        
    }
}
