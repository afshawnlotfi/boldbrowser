//
//  wsStorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/25/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


protocol WSStorageManagerDelegate{

    func wsStorageManager(_ wsStorageManager : WorkspaceStorageManager, didAddWorkspace workspace: Workspace , atTag : String)
    func wsStorageManager(_ wsStorageManager : WorkspaceStorageManager, didRemoveWorkspace atTag : String)
    func wsStorageManager(_ wsStorageManager : WorkspaceStorageManager, didSwitchWorkspace toTag : String)

}

class WorkspaceStorageManager:StorageManager<Workspace>{

    public var wsStorageManagerDelegate:WSStorageManagerDelegate?
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public var sCurrentWorkspace:String{
        let workspaceDefaults = WorkspaceKeyDefaults()
        return KeyStorageManager.getValue(from: workspaceDefaults)
    }
    
    public var currentWorkspace:Workspace{
        let filteredWorkspaces = self.dataObjects.filter{$0.title == sCurrentWorkspace}
        return filteredWorkspaces[0]
    }
    
    
    @discardableResult func addWorkspace(fromTag : String) -> Workspace{
        
        var workspaceDefaults = WorkspaceDefaults()
        workspaceDefaults.title = fromTag
        let workspace = self.addObject(from: workspaceDefaults)
        wsStorageManagerDelegate?.wsStorageManager(self, didAddWorkspace: workspace, atTag: fromTag)
        return workspace
    }
    
    
    
    func updateBackgroundImage(image : UIImage? = nil){
        
        if let bImage = image{
            appDelegate.browserViewController.changeBackgroundImage(image: bImage)
            if let finalData = UIImagePNGRepresentation(bImage){
                currentWorkspace.backgroundData = finalData
                self.saveContext()
            }
        }else{
            if let finalData = currentWorkspace.backgroundData{
                if let bImage = UIImage(data : finalData){
                    appDelegate.browserViewController.changeBackgroundImage(image: bImage)
                }
            }
        }
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
        if let tagName = self.dataObjects[self.dataObjects.count - 1].title{
            var workspaceDefaults = WorkspaceKeyDefaults()
            workspaceDefaults.value = tagName
            KeyStorageManager.setValue(from: workspaceDefaults)
            switchWorkspace(fromTag: tagName)
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
