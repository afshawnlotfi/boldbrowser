//
//  IKeyStorageDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

protocol IKeyStorageDefaults{
    var key:String {get}
    var value:Any {get set}
}
