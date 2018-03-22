//
//  WorkspaceStorageDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct WorkspaceKeyDefaults:IKeyStorageDefaults{
    private(set) var key: String = "workspace"
    var value: Any = String.empty
}
