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
    @discardableResult func addObject(from storageDefaults: IStorageDefaults) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: String(describing : StorageObject.self), in: context)
        let item = StorageObject(entity: entity!, insertInto: context)

        for (index, fieldname) in storageDefaults.fieldnames.enumerated(){
            item.setValue(storageDefaults.values[index], forKey: fieldname)
        }
        
        dataObjects.append(item)
        self.saveContext()
        return item
    }
    
    
    func saveContext(){
        do{
            try context.save()
        }catch{
            print("Failed to save to core data")
        }
        
    }
    
    /// Fetches Object from Core Data
    ///
    /// - Returns: Standard NSManagedObject which is casted to specific storage object later
    @discardableResult func fetchObjects(fromDisk : Bool) -> [NSManagedObject]{
        
        do{
            dataObjects = try context.fetch(StorageObject.fetchRequest()) as! [StorageObject]
        }catch let error as NSError{
            dataObjects = []
            print(error, ErrorStrings.FetchError)
        }
        
        if let orderedObjects = dataObjects as? [OrderedObject]{
            dataObjects = orderedObjects.sorted { $0.index < $1.index }
        }
        
        return dataObjects
    }
    
    
   
    func updateObject(updatedValues : [String:Any], object : NSManagedObject){
        for updatedValue in updatedValues{
            object.setValue(updatedValue.value, forKey: updatedValue.key)
        }
        self.saveContext()
    }
    
    func updateIndecies(range : CountableClosedRange<Int>){
        for index in range {
            if let orderedObject =  dataObjects[index] as? OrderedObject{
                self.updateObject(updatedValues: ["index" : index], object: orderedObject)
            }
        }
    }
    
    func updatePosition(current : Int, final : Int){
        let currentObject = dataObjects.remove(at: current)
        dataObjects.insert(currentObject, at: final)
        print(dataObjects)
        if current < final{
            updateIndecies(range: current...final)
        }else{
            updateIndecies(range: final...current)
        }
    }
    
    func deleteObject(index: Int) {
        context.delete(dataObjects[index])
        dataObjects.remove(at: index)
        self.saveContext()
    }
    
}
