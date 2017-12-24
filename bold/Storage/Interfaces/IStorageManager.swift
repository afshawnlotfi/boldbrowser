//
//  IStorageObject.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import CoreData


protocol IStorageManager {
    
    func addObject(from storageDefaults: IStorageDefaults)
    
    func fetchObjects() -> [NSManagedObject]
    
    func deleteObject(index : Int)
    
}
