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
    var dataObjects: [StorageObject] = []

    override init() {
        context = appDelegate.persistentContainer.viewContext
        super.init()
    }
    
    
    /// Adds Object to Core Data which is configured for IStorageDefaults
    ///
    /// - Parameter storageDefaults: Storage Dafaults of Object
    @discardableResult func addObject(from storageDefaults: ICDStorageDefaults) -> StorageObject {
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
    @discardableResult func fetchObjects(fromDisk : Bool) -> [StorageObject]{
        if fromDisk{
            do{
                dataObjects = try context.fetch(StorageObject.fetchRequest()) as! [StorageObject]
            }catch let error as NSError{
                dataObjects = []
                print(error, ErrorStrings.FetchError)
            }
            
            //Order objects if it is a OrderObject
            if let orderedObjects = dataObjects as? [OrderedObject]{
                if let storageObjects = (orderedObjects.sorted { $0.index < $1.index } as? [StorageObject]){
                    dataObjects = storageObjects
                }
            }
        }
        
        return dataObjects
    }
    
    
   
    func updateObject(updatedValues : [String:Any], object : NSManagedObject){
        for updatedValue in updatedValues{
            object.setValue(updatedValue.value, forKey: updatedValue.key)
        }
        self.saveContext()
    }
    
    ///Reindexes objects within range

    ///
    /// - Parameter range: Range to index
    func updateIndecies(bounds : [Int]){
        if let lowerBound = bounds.min(), let upperBound = bounds.max(){
             let range:CountableClosedRange<Int> = lowerBound...upperBound
                for index in range {
                    if let orderedObject =  dataObjects[index] as? OrderedObject{
                        self.updateObject(updatedValues: ["index" : index], object: orderedObject)
                    }
                }

            
        }

    }
    
    /// Updates new postion of object
    ///
    /// - Parameters:
    ///   - current: Previous Index
    ///   - final: Final Index
    func updatePosition(current : Int, final : Int){
        //Updates pos
        if current != final{
            let currentObject = dataObjects.remove(at: current)
            dataObjects.insert(currentObject, at: final)
            updateIndecies(bounds: [current, final])
            }
    }
    
    func deleteObjects(objects: [NSManagedObject]) {
        objects.forEach{context.delete($0)}
        self.saveContext()
        fetchObjects(fromDisk: true)
    }
    
}
