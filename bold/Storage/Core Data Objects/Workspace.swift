//
//  Workspace.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//
//

import Foundation
import CoreData



public class Workspace: NSManagedObject {
    
}


extension Workspace {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workspace> {
        return NSFetchRequest<Workspace>(entityName: "Workspace")
    }
    
    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var backgroundData: Data?
    @NSManaged public var savedTabs: NSSet?
    
}

// MARK: Generated accessors for savedTabs
extension Workspace {
    
    @objc(addSavedTabsObject:)
    @NSManaged public func addToSavedTabs(_ value: SavedTab)
    
    @objc(removeSavedTabsObject:)
    @NSManaged public func removeFromSavedTabs(_ value: SavedTab)
    
    @objc(addSavedTabs:)
    @NSManaged public func addToSavedTabs(_ values: NSSet)
    
    @objc(removeSavedTabs:)
    @NSManaged public func removeFromSavedTabs(_ values: NSSet)
    
}

