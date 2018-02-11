//
//  BookmarkManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class BookmarkManager:GMenuButtonDelegate{
    
    
    private var searchHashtag = SearchHashtagViewController()
    
    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
        if let bookmarkButtonDefault = buttonDefaults as? BookmarkButtonDefaults{
            let tab = bookmarkButtonDefault.tab
            searchHashtag.modalPresentationStyle = .overCurrentContext
            searchHashtag.presentView(forWebsite: "https://wikipedia.org")
            
//            addBookmark(title: tab.displayTitle,  url: tab.displayURL?.absoluteString ?? String.empty, faviconURL: tab.favicon?.faviconURL ?? String.empty)
        }
        
        
    }
    
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
       
        
        if let bookmarkButtonDefault = buttonDefaults as? BookmarkButtonDefaults{
            let tab = bookmarkButtonDefault.tab
            if let url = tab.displayURL{
                removeBookmark(url: url.absoluteString)

            }
        }
    
    
    
    }
    
    
    private let storageManager = StorageManager<Bookmark>()
    init() {
        self.storageManager.fetchObjects(fromDisk: true)
    }
    
 
    
    func isBookmark(url : String) -> Bool{
        return ((self.storageManager.dataObjects as! [Bookmark]).filter{$0.url == url }).count > 0
        
    }
    
    
    
    /// Adds bookmark to storage
    ///
    /// - Parameters:
    ///   - title: title of bookmark
    ///   - url: url of bookmark
    ///   - faviconURL: favicon of bookmark
    func addBookmark(title : String, url : String, faviconURL : String){
        var storageDefaults = WebsiteObjectDefaults()
        storageDefaults.title = title
        storageDefaults.url = url
        storageDefaults.faviconURL = faviconURL
        storageManager.addObject(from: storageDefaults)
        
    }
    
    func removeBookmark(url : String){
        
        let bookmarks = (self.storageManager.dataObjects as! [Bookmark]).filter{$0.url == url }
        storageManager.deleteObjects(objects: bookmarks)
        
    }
    
}

