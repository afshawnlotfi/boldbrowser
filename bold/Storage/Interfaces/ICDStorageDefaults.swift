//
//  IStorageObject.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import CoreData

protocol ICDStorageDefaults{

}

extension ICDStorageDefaults{

    var fieldnames: [String] {
        let result = Mirror(reflecting: self).children.map {
            $0.label!
        }
        return result
    }
    
    var values: [Any] {
        let result = Mirror(reflecting: self).children.map {
            $0.value
        }
        return result
    }
}

