//
//  SavedTab+CoreDataClass.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//
//

import Foundation
import CoreData


public class SavedTab: NSManagedObject {
    
}

extension SavedTab {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedTab> {
        return NSFetchRequest<SavedTab>(entityName: "SavedTab")
    }
    
    convenience init(sessionData : NSData) {
        self.init()
    }
    
    @NSManaged public var faviconURL: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var screenshotUUID: UUID?
    @NSManaged public var sessionData: NSData?
    @NSManaged public var title: String?
    
}
