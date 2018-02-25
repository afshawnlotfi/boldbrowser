//
//  TagManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/25/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


class TagManager:NSObject{
    
    private var storageManager = StorageManager<SavedTag>()
    
    
    func getTags(forURL : String) -> [String]{
        
        if let allTags = storageManager.fetchObjects(fromDisk: true) as? [SavedTag]{
            let tags = allTags.filter{
                $0.url == forURL
            }
            return tags.map{$0.tagName ?? String.empty}

        }
        return []
        
    }

    func addTag(tagName : String , forURL : String) {

            if let tags = storageManager.fetchObjects(fromDisk: false) as? [SavedTag]{
                let identifiedTags = tags.filter{
                    $0.tagName == tagName
                }
                if identifiedTags.count == 0{
                    var storageDefaults = TagDefaults()
                    storageDefaults.tagName = tagName
                    storageDefaults.url = forURL
                    storageManager.addObject(from: storageDefaults)
                }
            }
        
    }
    
    func removeTag(tagName : String , forURL : String) {

            if let tags = storageManager.dataObjects as? [SavedTag]{
                let identifiedTags = tags.filter{
                    $0.tagName == tagName && $0.url == forURL
                }
                storageManager.deleteObjects(objects: identifiedTags)
            }
    }
    
    
    
}
