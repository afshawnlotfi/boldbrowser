//
//  SessionDataManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation


protocol TabSessionDelegate: class {
    func tabSession(_ tabSession: TabSession, didUpdateBackList backList: Tab)
    func tabSession(_ tabSession: TabSession, didUpdateForwardList forwardList: Tab)
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
    
}


// MARK: - Updated TabSession object when Tab switches pages
extension TabSession:TabSessionDelegate{
    func tabSession(_ tabSession: TabSession, didUpdateBackList backList: Tab) {
        
    }
    
    func tabSession(_ tabSession: TabSession, didUpdateForwardList forwardList: Tab) {
        
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
