//
//  WorkspaceStorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit
import CoreData

//protocol WorkspaceManagerDelegate{
//    
//    func workspaceManager(_ workspaceManager : WorkspaceManager, didAddWorkspace tag: String , atIndex : Int)
//    func workspaceManager(_ workspaceManager : WorkspaceManager, didRemoveWorkspace tag: String, atIndex : Int)
//    
//}


class SavedTabStorageManager:StorageManager<SavedTab>{
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext
    private var workspaceManager:StorageManager<Workspace>
    
    init(workspaceManager : StorageManager<Workspace>){
        context = appDelegate.persistentContainer.viewContext
        workspaceManager.fetchObjects(fromDisk: true)
        self.workspaceManager = workspaceManager
    }
    
    @discardableResult func addObject(from storageDefaults: ICDStorageDefaults, tagName : String) -> SavedTab {
        
        let savedTab = self.addObject(from: storageDefaults)
        workspaceFromTag(tagName: tagName, fromDisk : false).addToSavedTabs(savedTab)
        self.saveContext()
        return savedTab
        
    }

    func workspaceFromTag(tagName : String, fromDisk : Bool) -> Workspace{
        
        let workspaces = (workspaceManager.fetchObjects(fromDisk: fromDisk)).filter{
            
            $0.title == tagName
            
        }
        if workspaces.count > 0{
            return workspaces[0]
        }else{
            var workspaceDefaults = WorkspaceDefaults()
            workspaceDefaults.title = tagName
            let workspace = self.workspaceManager.addObject(from: workspaceDefaults)
            return workspace
        }
        
    }
    
    @discardableResult func fetchObjects(fromDisk : Bool, tagName : String) -> [SavedTab]{
        
        let workspace = workspaceFromTag(tagName: tagName, fromDisk : fromDisk)
        if let savedTabs = (workspace.savedTabs?.allObjects) as? [SavedTab]{
            dataObjects = (savedTabs.sorted { $0.index < $1.index })
        }else{
            dataObjects = []
        }
        return dataObjects

        
        
    }

    
}

