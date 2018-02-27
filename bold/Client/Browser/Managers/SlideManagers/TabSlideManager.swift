//
//  TabSlideManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/20/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class TabSlideManager:OptionSlideManager{
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            let option = selectionManager.items[indexPath.section][indexPath.row]
            if let gCell = tableView.cellForRow(at: indexPath) as? GTableViewCell, let webView = self.bottomView as? TabWebView{
                option.delegate?.sliderOption!(didSelectCell: gCell, webView: webView)
    
            }
        }
}




