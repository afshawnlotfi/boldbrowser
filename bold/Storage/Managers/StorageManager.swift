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

class StorageManager<StorageObject:NSManagedObject>:NSObject{
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext
    var dataObjects: [NSManagedObject]

    override init() {
        context = appDelegate.persistentContainer.viewContext
        dataObjects = []
        super.init()
    }
    
    
    /// Adds Object to Core Data which is configured for IStorageDefaults
    ///
    /// - Parameter storageDefaults: Storage Dafaults of Object
    func addObject(from storageDefaults: IStorageDefaults) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: String(describing : StorageObject.self), in: context)
        let item = StorageObject(entity: entity!, insertInto: context)

        for (index, fieldname) in storageDefaults.fieldnames.enumerated(){
            item.setValue(storageDefaults.values[index], forKey: fieldname)
        }
        
        dataObjects.append(item)
        appDelegate.saveContext()
        return item
    }
    
    
    /// Fetches Object from Core Data
    ///
    /// - Returns: Standard NSManagedObject which is casted to specific storage object later
    func fetchObjects(fromDisk : Bool) -> [NSManagedObject]{

        do{
            dataObjects = try context.fetch(StorageObject.fetchRequest()) as! [StorageObject]
        }catch let error as NSError{
            dataObjects = []
            print(error, ErrorStrings.FetchError)
        }
        return dataObjects
    }
    
    func updateObject(updatedValues : [String:Any], object : StorageObject){
        for updatedValue in updatedValues{
            object.setValue(updatedValue.value, forKey: updatedValue.key)
        }
        appDelegate.saveContext()
    }
    
    
    func updateIndecies(current: Int, final: Int) {
        
    }
    
    func deleteObject(index: Int) {
        
    }
    
}
