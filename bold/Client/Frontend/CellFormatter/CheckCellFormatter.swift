//
//  CheckCellFormatter.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class CheckCellFormatter:ITVCellFormatter{
    func tableView(item: Any, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()

    }
    
    
    func updateItems(items: [Any]) {
        self.items = items
    }
    
    var items: [Any]

    
    init(items: [Any]) {
        self.items = items
    }
    

    
    

}
