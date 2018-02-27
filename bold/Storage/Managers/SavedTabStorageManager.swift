//
//  WorkspaceStorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit
import CoreData


class SavedTabStorageManager:StorageManager<SavedTab>{
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext
    private var wsStorageManager:WorkspaceStorageManager
    init(wsStorageManager : WorkspaceStorageManager){
        context = appDelegate.persistentContainer.viewContext
        self.wsStorageManager = wsStorageManager
    }
    
    @discardableResult func addObject(from storageDefaults: ICDStorageDefaults, tagName : String) -> SavedTab {
        let savedTab = self.addObject(from: storageDefaults)
        self.wsStorageManager.addSavedTab(savedTab : savedTab, forTag: tagName)
        return savedTab
    }
    
    @discardableResult func fetchObjects(fromDisk : Bool, tagName : String) -> [SavedTab]{
        
        let workspace = self.wsStorageManager.getWorkspace(fromTag: tagName, fromDisk : fromDisk)
        if let savedTabs = (workspace.savedTabs?.allObjects) as? [SavedTab]{
            dataObjects = (savedTabs.sorted { $0.index < $1.index })
        }else{
            dataObjects = []
        }
        return dataObjects
    }
    
}

