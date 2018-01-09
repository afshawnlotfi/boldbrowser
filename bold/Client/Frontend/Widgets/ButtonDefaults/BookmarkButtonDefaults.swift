//
//  BookmarkButtonDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/7/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct BookmarkButtonDefaults:IButtonDefaults{
    
    let buttonTab:Tab!
    init(tab : Tab){
        buttonTab = tab
    }
    
    var selectedImage: UIImage = #imageLiteral(resourceName: "bookmark-small")
    var unselectedImage: UIImage = #imageLiteral(resourceName: "remove-bookmark-small")
    var isSelected = false
    
    var tab:Tab{
        return buttonTab
    }
}
