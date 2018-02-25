//
//  BrowserInfo.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

open class BrowserInfo {
    
    class var currentWorkspace:String{
        let workspaceKeyDefaults = WorkspaceKeyDefaults()
        return KeyStorageManager.getValue(from: workspaceKeyDefaults)
    }

}

