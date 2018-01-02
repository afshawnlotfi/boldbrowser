//
//  Favicon+CoreDataClass.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/1/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Favicon: NSManagedObject {

  
    
    class func DefaultFavicon(faviconURL : String , faviconData : Data) -> Favicon{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favicon", in: context)
        let favicon = Favicon(entity: entity!, insertInto: context)
        favicon.faviconData = faviconData
        favicon.faviconURL = faviconURL
        return favicon
    }
    
    
}

extension Favicon {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favicon> {
        return NSFetchRequest<Favicon>(entityName: "Favicon")
    }
    
    @NSManaged public var faviconData: Data?
    @NSManaged public var faviconURL: String?
    
}
