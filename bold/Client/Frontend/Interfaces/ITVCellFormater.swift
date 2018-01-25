//
//  ITVCellFormater.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol ITVCellFormatter {
    func tableView(item : Any, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
