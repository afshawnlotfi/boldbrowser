//
//  WorkspaceStorageDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct WorkspaceKeyDefaults:IKeyStorageDefaults{
    var key: String = "workspace"
    var value: String = String.empty
}
