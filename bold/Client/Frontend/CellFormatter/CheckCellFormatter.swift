//
//  CheckCellFormatter.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit




class CheckCellFormatter:NSObject, ITVCellFormatter{
    private var selectionManager:SelectionManager<String>
    public var checkBtnDelegate:GMenuButtonDelegate?
    init(selectionManager : SelectionManager<String>) {
        self.selectionManager = selectionManager
        
    }
    
    func tableView(item: Any, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let tTableCell = tableView.dequeueReusableCell(withIdentifier: GIdentifierStrings.TableViewCell, for: indexPath) as? GTableViewCell,  let title = item as? String{
            
            tTableCell.textLabel?.text = title
            tTableCell.selectionStyle = .none
            var buttonDefaults = CheckButtonDefaults()
            for item in selectionManager.items[indexPath.section]{
                if item == title{
                    buttonDefaults.isSelected = true
                    break
                }
            }
            tTableCell.addMenuBtn(buttonDefaults: buttonDefaults)

            return tTableCell
        }else{
            return UITableViewCell()
        }
    }


    
    

}
