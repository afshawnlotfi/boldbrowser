//
//  StorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class StorageManager<StorageObject:NSManagedObject>:NSObject,IStorageManager{
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy private var dataObjects = [StorageObject]()
    private var context: NSManagedObjectContext
    
    override init() {
        context = appDelegate.persistentContainer.viewContext
        super.init()
    }
    
    
    /// Adds Object to Core Data which is configured for IStorageDefaults
    ///
    /// - Parameter storageDefaults: Storage Dafaults of Object
    func addObject(from storageDefaults: IStorageDefaults) {
        let entity = NSEntityDescription.entity(forEntityName: String(describing : StorageObject.self), in: context)
        let item = StorageObject(entity: entity!, insertInto: context)

        for (index, fieldname) in storageDefaults.fieldnames.enumerated(){
            item.setValue(storageDefaults.values[index], forKey: fieldname)
        }
        
        dataObjects.append(item)
        appDelegate.saveContext()
        
    }
    
    
    /// Fetches Object from Core Data
    ///
    /// - Returns: Standard NSManagedObject which is casted to specific storage object later
    func fetchObjects() -> [NSManagedObject] {

        do{
            dataObjects = try context.fetch(StorageObject.fetchRequest()) as! [StorageObject]
        }catch let error as NSError{
            dataObjects = []
            print(error, ErrorStrings.FetchError)
        }
        return dataObjects
    }
    
    
    func updateIndecies(current: Int, final: Int) {
        
    }
    
    func deleteObject(index: Int) {
        
    }
    
}
