//
//  WorkspaceDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct WorkspaceDefaults:ICDStorageDefaults{
    var title:String =  String.empty
    private(set) var dateCreated:Date = Date(timeIntervalSince1970: Date.timeIntervalBetween1970AndReferenceDate)
    var backgroundData = UIImagePNGRepresentation(#imageLiteral(resourceName: "background-image")) ?? Data()
}
