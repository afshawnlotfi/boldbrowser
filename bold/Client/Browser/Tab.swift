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
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView)
}

class Tab:NSObject{
    private var configuration: WKWebViewConfiguration?
    private(set) var tabScriptManager = TabScriptManager()
    var webView:WKWebView?
    var tabDelegate:TabDelegate?
    var tabSession:TabSession?
    var lastSavedTitle:String?
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
    
    func createWebview(){
        
        if webView == nil {
            let webView = TabWebView(frame: CGRect.zero, configuration: configuration!)
            restoreWebview(webView)
            self.webView = webView
            tabDelegate?.tab(self, didCreateWebview: webView)
            
        }
        
    }
    
    
    func restoreWebview(_ webView: WKWebView) {
        
        if let tabSession = self.tabSession{
            let savedURL = tabSession.urls[tabSession.currentPage]
            let request = URLRequest(url: savedURL)
            webView.load(request)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let webview = object as? TabWebView{
            if let key = keyPath{
                switch key {
                case BrowserStrings.EstimatedProgressObserver:
                    webview.progressBarUpdated()
                case BrowserStrings.TitleObserver:
                    break
                case BrowserStrings.URLObserver:
                    break
                default:
                    break
                }
            }
        }
        
    }
  

 
 
    
}


