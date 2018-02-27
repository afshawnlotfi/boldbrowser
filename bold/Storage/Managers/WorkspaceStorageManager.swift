//
//  wsStorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/25/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


protocol WSStorageManagerDelegate{

    func wsStorageManager(_ wsStorageManager : WorkspaceStorageManager, didAddWorkspace workspace: Workspace , atTag : String)
    func wsStorageManager(_ wsStorageManager : WorkspaceStorageManager, didRemoveWorkspace atTag : String)
    func wsStorageManager(_ wsStorageManager : WorkspaceStorageManager, didSwitchWorkspace toTag : String)

}

class WorkspaceStorageManager:StorageManager<Workspace>{

    public var wsStorageManagerDelegate:WSStorageManagerDelegate?
    
    @discardableResult func addWorkspace(fromTag : String) -> Workspace{
        var workspaceDefaults = WorkspaceDefaults()
        workspaceDefaults.title = fromTag
        let workspace = self.addObject(from: workspaceDefaults)
        wsStorageManagerDelegate?.wsStorageManager(self, didAddWorkspace: workspace, atTag: fromTag)
        return workspace
    }
    
    func switchWorkspace(fromTag : String){
        var workspaceDefaults = WorkspaceKeyDefaults()
        workspaceDefaults.value = fromTag
        KeyStorageManager.setValue(from: workspaceDefaults)
        wsStorageManagerDelegate?.wsStorageManager(self, didSwitchWorkspace: fromTag)
    }
    
    func addSavedTab(savedTab : SavedTab , forTag : String){
        self.getWorkspace(fromTag: forTag, fromDisk: false).addToSavedTabs(savedTab)
        self.saveContext()
    }
    
    func removeWorkspace(fromTag : String){
        
        let workspaces = searchWorkspace(fromKeyword: fromTag)
        if workspaces.count > 0{
            self.deleteObjects(objects: [workspaces[0]])
        }
        wsStorageManagerDelegate?.wsStorageManager(self, didRemoveWorkspace: fromTag)
    }
    
    func searchWorkspace(fromKeyword : String) -> [Workspace]{
        return ((self.fetchObjects(fromDisk: false)).filter{
            $0.title == fromKeyword
        })
    }
    
    func getWorkspace(fromTag : String, fromDisk : Bool) -> Workspace{
        let workspaces = searchWorkspace(fromKeyword: fromTag)
        if workspaces.count > 0{
            return workspaces[0]
        }else{
            return addWorkspace(fromTag: fromTag)
        }
    }
    
}
