//
//  BackgroundPromptManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 3/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class BackgroundPromptManager:NSObject{
    private var wsSlideManager:WorkspaceSlideManager
    
    init(wsSlideManager : WorkspaceSlideManager){
        self.wsSlideManager = wsSlideManager
        super.init()
    }
    
    @objc func imageCanceledPrompt(){
        let alert = UIAlertController(title: "Image Set", message: "Which image would you like to set?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Current Image", style: .cancel, handler: { [] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Default Image", style: .default, handler: { [] (_) in
            self.wsSlideManager.wsStorageManager.updateBackgroundImage(image: #imageLiteral(resourceName: "background-image"))
            self.wsSlideManager.imageView.image = #imageLiteral(resourceName: "background-image")
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}


