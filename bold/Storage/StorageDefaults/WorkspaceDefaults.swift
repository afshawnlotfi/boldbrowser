//
//  WorkspaceDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct WorkspaceDefaults:ICDStorageDefaults{
    var title:String =  String.empty
    var dateCreated:Date = Date(timeIntervalSince1970: Date.timeIntervalBetween1970AndReferenceDate)
}
