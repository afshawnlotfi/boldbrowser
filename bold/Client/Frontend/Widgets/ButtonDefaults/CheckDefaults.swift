//
//  CheckDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct CheckButtonDefaults:IButtonDefaults{
    
    var selectedImage: UIImage = #imageLiteral(resourceName: "selected")
    var unselectedImage: UIImage = #imageLiteral(resourceName: "unselected")
    var isSelected = false
    var identifier:Any?
    
}
