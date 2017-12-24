//
//  TabManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit

protocol TabManagerDelegate: class {
    func tabManager(_ tabManager: TabManager, addTab tab: Tab)
    func tabManager(_ tabManager: TabManager, removeTab tab: Tab)
}


class TabManager:NSObject{
    
    private(set) var tabs:[Tab]
    var tabManagerDelegate:TabManagerDelegate?
    
    override init() {
//        let config = WKWebViewConfiguration()
        tabs = []
        super.init()
        
    }
    
    func addTab(atindex : Int, configuration : WKWebViewConfiguration, urlRequest : URLRequest) -> Tab{
        return Tab(configuration: configuration)
    }
  
 
    
}
