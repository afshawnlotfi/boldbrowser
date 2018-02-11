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
    func selectionManager(didRemoveObject : IndexPath, item : Any)
}


class SelectionManager<DataObject:Any>:NSObject,GMenuButtonDelegate{
    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index: Int) {
        if let checkButtonDefault = buttonDefaults as? CheckButtonDefaults{
            if let identifier = checkButtonDefault.identifier as? DataObject{
                self.addItem(item: identifier, section: 0)
            }
        }
    }
    
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index: Int) {
        if let checkButtonDefault = buttonDefaults as? CheckButtonDefaults{
            if let identifier = checkButtonDefault.identifier as? String{
                for (index,item) in items[0].enumerated(){
                    if (item as! String) == identifier{
                        self.removeItem(row: index, section: 0)
                    }
                }
            
            }
        }
    }
    
    public var selectionManagerDelegate:SelectionDelegate?
    public var items:[[DataObject]] = []

  
    public func addItem(item : DataObject, section : Int){
        items[section].append(item)
        selectionManagerDelegate?.selectionManager(didAddObject:  IndexPath(row: items.count, section : section), item: item)
    }
    
    public func removeItem(row : Int, section : Int){
        let item = items[section][row]
        items[section].remove(at: row)
        selectionManagerDelegate?.selectionManager(didRemoveObject: IndexPath(row: row, section : section), item : item)

    }
    
}
