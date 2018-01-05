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
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView, atIndex : Int)
    func tab(_ tab : Tab, didFinishLoading atIndex : Int)
    func tab(_ tab : Tab, didUpdateTitle title : String, atIndex : Int)
    func tab(_ tab : Tab, didUpdateFavicon favicon : Favicon, atIndex : Int)
    func tab(_ tab : Tab, didUpdateProgress webView : TabWebView, atIndex : Int)

}

class Tab:NSObject{
    private var configuration: WKWebViewConfiguration?
    var webView:TabWebView?
    var tabDelegate:TabDelegate?
    var tabSession:TabSession?
    var favicon:Favicon?
    var lastTitle:String?
    var screenshotImage:UIImage?
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
            self.webView = TabWebView(frame: CGRect.zero, configuration: configuration!)
            tabDelegate?.tab(self, didCreateWebview: webView!, atIndex : (self.webView?.tag)!)
          
        }
    }
    
    
    func restoreWebview() {
        
        if let tabSession = self.tabSession{
            if tabSession.urls.count > 0{
                let savedURL = tabSession.urls[tabSession.currentPage]
                let request = URLRequest(url: savedURL)
                self.webView?.load(request)
            }
        }
    }
    
    
  

 
 
    
}


