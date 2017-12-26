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
    func tabManager(_ tabManager: TabManager, addTab at : IndexPath)
    func tabManager(_ tabManager: TabManager, removeTab at : IndexPath)
    func tabManager(_ tabManager: TabManager, selectedTab at : IndexPath)

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
            tabManagerDelegates.forEach{$0.tabManager(self, addTab: tabIndex); $0.tabManager(self, selectedTab: tabIndex)}
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
        
        
        
    
    
 
    
}
