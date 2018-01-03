//
//  SessionDataManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

protocol TabSessionDelegate: class {
    func tabSession(_ tabSession: TabSession, didUpdateSession backList: Tab)
}


class TabSession:NSObject{
    
    private(set) var urls : [URL]
    private(set) var currentPage: Int

    var tabSessionDelegate:TabSessionDelegate?
    
    var jsonDict:[String:Any] {
        return [
            "urls" : self.urls.map{ $0.absoluteString},
            "currentPage" : self.currentPage

        ]
    }
    
    var data:Data {
        return JSONParser.serialize(dict: jsonDict)
    }

    init(urls : [URL], currentPage : Int) {
        self.urls = urls
        self.currentPage = currentPage
    }
    
    convenience init(data : Data) {
        let tabSession = JSONParser.deserialize(data: data)
        let urls = (tabSession["urls"] as? [String])!.map{ $0.convertToURL() }
        let currentPage = tabSession["currentPage"] as! Int
        self.init(urls: urls, currentPage: currentPage)
    }
    
    func updateSession(urls : [URL], currentPage : Int){
        self.urls = urls
        self.currentPage = currentPage
    }
    
    func updateSession(tab : Tab){
            if let webView = tab.webView{
                
                let backList = webView.backForwardList.backList.map{$0.url}
                let forwardList = webView.backForwardList.forwardList.map{$0.url}
                var currentURLList:[URL]{
                    if let currentURL = webView.backForwardList.currentItem?.initialURL{
                        return [currentURL]
                    }else{
                        if self.urls.count > 0{
                            return [self.urls[currentPage]]
                        }else{
                            return []
                        }
                    }
                }
                
                self.updateSession(urls: backList + currentURLList + forwardList, currentPage: backList.count)
            }
    }
}




// MARK: - Blank Session for New Tab
extension TabSession{
    
    static var defaultData:Data{
        let dict:[String : Any] =  [
            "urls" : [BrowserStrings.NewTabURL],
            "currentPage" : 0
            ]
        return JSONParser.serialize(dict: dict)
    }

}
