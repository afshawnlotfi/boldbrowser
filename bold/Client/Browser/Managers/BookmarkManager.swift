//
//  BookmarkManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

class BookmarkManager:GMenuButtonDelegate{

    
    
    private let storageManager = StorageManager<Bookmark>()
    init() {
        self.storageManager.fetchObjects(fromDisk: true)
    }
    
    func gMenuButton(didSelectButton button: GMenuButton, withDescriptor: [String : Any]) {
        addBookmark(title: withDescriptor["title"] as! String, url: withDescriptor["url"] as! String, faviconURL: withDescriptor["faviconURL"] as! String)
    }
    
    func gMenuButton(didUnselectButton button: GMenuButton, withDescriptor: [String : Any]) {
        removeBookmark(url: withDescriptor["url"] as! String)
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

