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
        
        let allTags = storageManager.fetchObjects(fromDisk: true)
        let tags = allTags.filter{
            $0.url == forURL
        }
        return tags.map{$0.tagName ?? String.empty}

        
    }

    func addTag(tagName : String , forURL : String) {

            let tags = storageManager.fetchObjects(fromDisk: false)
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
    
    func removeTag(tagName : String , forURL : String) {

        let tags = storageManager.dataObjects
                let identifiedTags = tags.filter{
                    $0.tagName == tagName && $0.url == forURL
                }
            storageManager.deleteObjects(objects: identifiedTags)
    
    }
    
    
    
}
