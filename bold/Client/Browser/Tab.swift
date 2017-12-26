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
    func tab(_ tab: Tab, didCreateWebView webView: WKWebView)
    func tab(_ tab: Tab, willDeleteWebView webView: WKWebView)
}

class Tab:NSObject{
    private var configuration: WKWebViewConfiguration?
    var webView:WKWebView?
    var tabDelegate:TabDelegate?
    var tabSession:TabSession?
    var displayTitle: String {
        if let title = webView?.title, !title.isEmpty {
            return title
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
    
    func assignWebview(){
        
        if webView == nil {
            let webView = TabWebView(frame: CGRect.zero, configuration: configuration!)
            restoreWebview(webView)
            tabDelegate?.tab(self, didCreateWebView: webView)
            self.webView = webView
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

