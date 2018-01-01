//
//  Tab.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit


protocol TabDelegate {
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView, atIndex : IndexPath)
}

class Tab:NSObject{
    private var configuration: WKWebViewConfiguration?
    var webView:TabWebView?
    var tabDelegate:TabDelegate?
    var tabSession:TabSession?
    var favicon:Favicon?
    var lastTitle:String?
    var displayTitle: String {
        if let title = webView?.title, !title.isEmpty {
            return title
        }else if let lastTitle = self.lastTitle{
            return lastTitle
        }else if let url = displayURL?.absoluteString{
            return url
        }else{
            return BrowserStrings.NoTitle
        }
    }

    var displayURL: URL? {
        return webView?.url
    }
    
    
    init(configuration: WKWebViewConfiguration) {
        super.init()
        self.configuration = configuration
    }
    
    func createWebview(){
        
        if webView == nil {
            let webView = TabWebView(frame: CGRect.zero, configuration: configuration!)
            restoreWebview(webView)
            self.webView = webView
            tabDelegate?.tab(self, didCreateWebview: webView, atIndex : IndexPath(row: webView.tag, section: 0))
            
        }
        
    }
    
    
    func restoreWebview(_ webView: WKWebView) {
        
        if let tabSession = self.tabSession{
            let savedURL = tabSession.urls[tabSession.currentPage]
            let request = URLRequest(url: savedURL)
            webView.load(request)
        }
    }
    
    
  

 
 
    
}


