//
//  SelectionManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/26/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


protocol SelectionDelegate {
    func selectionManager(didAddObject : IndexPath, item : Any)
    func selectionManager(didRemoveObject : IndexPath)
}


class SelectionManager<DataObject:Any>:NSObject{
    public var selectionManagerDelegate:SelectionDelegate?
    public var items:[[DataObject]] = []

  
    public func addItem(item : DataObject, section : Int){
        items[section].append(item)
        selectionManagerDelegate?.selectionManager(didAddObject:  IndexPath(row: items.count, section : section), item: item)
    }
    
    public func removeItem(row : Int, section : Int){
        items[section].remove(at: row)
        selectionManagerDelegate?.selectionManager(didRemoveObject: IndexPath(row: row, section : section))

    }
    
}
