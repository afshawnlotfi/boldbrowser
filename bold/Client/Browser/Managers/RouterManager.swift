//
//  RouterManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/17/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


class RouterManager:NSObject{
    
    private var storageManager = StorageManager<DownloadedWebsite>()

    
    override init() {
        storageManager.fetchObjects(fromDisk: true)
        super.init()
    }
    
    
    
    
    func route(webView : TabWebView){

        switch DeviceInfo.hasConnectivity(){
            case true:
                webView.offlineLoaded = false
            case false:
                loadOffline(forUrl: webView.url!, webview: webView)
            
        }
    }
    
    
    /// Loads offline copy of website
    ///
    /// - Parameter url: url to attempt to load
    func loadOffline(forUrl : URL, webview : TabWebView){
        let matchingIndecies = ((self.storageManager.fetchObjects(fromDisk: false)).filter{ $0.url == forUrl.absoluteString})
        
        if matchingIndecies.count > 0{
            let downloaded = matchingIndecies[matchingIndecies.count - 1]
            if let data = downloaded.data, let url = downloaded.url{
                if let html = String(data: data, encoding: .utf8), let baseURL = URL(string: url) {
                    webview.loadHTMLString(html, baseURL: baseURL)
                }else{
                    self.loadOffline(webview : webview)
                }
            }else{
                self.loadOffline(webview : webview)
            }
        }else{
            self.loadOffline(webview : webview)
        }
        
    }
    
    func loadOffline(webview : TabWebView){
        if let path = Bundle.main.path(forResource: "offlineNotice", ofType: "html", inDirectory: "HTML") {
            webview.load( URLRequest(url: URL(fileURLWithPath: path)) )
            webview.offlineLoaded = true
        }
    }

    
}


    

