//
//  DownloadManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/15/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit


protocol DownloadManagerDelegate {
    func downloadManager(_ downloadManager : DownloadManager, didTakeSnapshot HTMLString : String)
}

class DownloadManager:ITabPluginManager{
    
    public var downloadManagerDelegate:DownloadManagerDelegate?
    private var storageManager = StorageManager<DownloadedWebsite>()
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let responseArray:String = message.body as? String{
            
            do{
                
                let parsedData = try JSONSerialization.jsonObject(with: responseArray.data(using: .utf8)!, options: []) as! Dictionary<String,AnyObject>
                
                if let url = parsedData["url"] as? String, let html = parsedData["html"] as? String , let scripts = parsedData["scripts"] as? Array<String>, let styles = parsedData["styles"] as? Array<String> {
                    parseResources(webSource: WebSourceObject(url : url , html: html, js: scripts, css: styles))
                }
            }catch{
                print(ErrorStrings.DownloadParse)
            }
        }
    }
    
    
    private func parseResources(webSource : WebSourceObject){
        

        
        var HTMLScript = String()
        var HTMLStyle = String()
        
        
        webSource.css.forEach{
            if let url = URL(string: $0){
                let responseData = WebRequestManager.fetchData(fetchURL: url, httpMethod: HTTPRequest.GET)
                if let stringFromData = String(data: responseData, encoding: .utf8){
                    HTMLStyle +=  "<style>" + stringFromData + "</style>"
                }
            }
        }
        
        webSource.js.forEach{
            if let url = URL(string: $0){
                let responseData = WebRequestManager.fetchData(fetchURL: url, httpMethod: HTTPRequest.GET)
                if let stringFromData = String(data: responseData, encoding: .utf8){
                    HTMLScript +=  "<script>" + stringFromData + "</script>"
                }
                
            }
        }
        

        
        
        let HTMLSnapshot = webSource.html.replacingOccurrences(of: "</head>", with: HTMLStyle + HTMLScript + "</head>")
        
        let storageDefaults = DownloadedWebsiteDefaults(url: webSource.url, data: HTMLSnapshot.data(using: .utf8) ?? Data())

        let matchingIndecies = ((self.storageManager.dataObjects).filter{ $0.url == storageDefaults.url})
        
        if matchingIndecies.count == 0{
            self.storageManager.addObject(from: storageDefaults)
        }
        
        downloadManagerDelegate?.downloadManager(self, didTakeSnapshot: HTMLSnapshot)

    }
    
    
    
    
}
