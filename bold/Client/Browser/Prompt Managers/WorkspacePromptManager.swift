//
//  WorkspacePromptManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 3/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class WorkspacePromptManager:NSObject{
    private var wsSlideManager:WorkspaceSlideManager
    
    init(wsSlideManager : WorkspaceSlideManager){
        self.wsSlideManager = wsSlideManager
        super.init()
    }
    
    
    @objc func addWorkspacePrompt(){
        let alert = UIAlertController(title: "Create Workspace", message: "Enter a title", preferredStyle: .alert)
            alert.addTextField { (textField) in
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if let textTitle = (textField?.text){
                self.wsSlideManager.wsStorageManager.addWorkspace(fromTag: textTitle)
                self.wsSlideManager.invokeTagSwitchEvent(tagName: textTitle)
            }
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func removeWorkSpacePrompt(){

        if self.wsSlideManager.wsStorageManager.dataObjects.count > 1 {
            let alert = UIAlertController(title: "Delete Workspace", message: "Are you sure you want to delete this workspace?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [] (_) in

            }))

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [] (_) in

                self.wsSlideManager.wsStorageManager.removeWorkspace(fromTag: self.wsSlideManager.wsStorageManager.sCurrentWorkspace)
                self.wsSlideManager.invokeTagSwitchEvent(tagName: self.wsSlideManager.wsStorageManager.sCurrentWorkspace)

            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)


        }else{
            let alert = UIAlertController(title: "Workspace Minimum", message: "You must create at least one workspace to proceed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [] (_) in

            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

}
