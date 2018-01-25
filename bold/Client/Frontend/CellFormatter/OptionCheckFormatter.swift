//
//  OptionCheckFormatter.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class OptionTVCellFormatter:ITVCellFormatter{
    

   
    
    func tableView(item : Any, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let tTableCell = tableView.dequeueReusableCell(withIdentifier: GIdentifierStrings.TableViewCell, for: indexPath) as? GTableViewCell,  let option = item as? GMenuOption{
            
            
            if (option.includeSwitch){
                tTableCell.addSwitch(isOn: false)
            }
            tTableCell.backgroundColor = .clear
            tTableCell.textLabel?.text = option.title
            if let icon = option.icon{
                tTableCell.imageView?.image = icon
            }
            return tTableCell
        }else{
            return UITableViewCell()
        }
            
    }
    
}


