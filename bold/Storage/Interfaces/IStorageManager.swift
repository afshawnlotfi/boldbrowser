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
    
    var dataObjects:[NSManagedObject] {get}

    func addObject(from storageDefaults: IStorageDefaults) -> NSManagedObject
    
    func fetchObjects(fromDisk : Bool) -> [NSManagedObject]
    
    func deleteObject(index : Int)
    
}
