//
//  WorkspaceStorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit
import CoreData
class WorkspaceStorageManager:StorageManager<SavedTab>{
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext
    private var workspaceManager:StorageManager<Workspace>
    
    init(workspaceManager : StorageManager<Workspace>){
        context = appDelegate.persistentContainer.viewContext
        self.workspaceManager = workspaceManager
    }
    
    @discardableResult func addObject(from storageDefaults: ICDStorageDefaults, tagName : String) -> SavedTab {
        
        let savedTab = self.addObject(from: storageDefaults) as? SavedTab
        workspaceFromTag(tagName: tagName).addToSavedTabs(savedTab!)
        self.saveContext()
        return savedTab!
        
    }

    func workspaceFromTag(tagName : String) -> Workspace{
        
        let workspaces = (workspaceManager.fetchObjects(fromDisk: true) as! [Workspace]).filter{
            
            $0.title == tagName
            
        }
        
        if workspaces.count > 0{
            return workspaces[0]
        }else{
            var workspaceDefaults = WorkspaceDefaults()
            workspaceDefaults.title = tagName
            let workspace = self.workspaceManager.addObject(from: workspaceDefaults)
            return workspace as! Workspace
        }
        
    }
    
    @discardableResult func fetchObjects(fromDisk : Bool, tagName : String) -> [SavedTab]{
        
        let workspace = workspaceFromTag(tagName: tagName)
        if let savedTabs = (workspace.savedTabs?.allObjects) as? [SavedTab]{
            return savedTabs
        }else{
            return []
        }

    }
}

