//
//  GenericButtonDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/13/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct GenericButtonDefaults:IButtonDefaults{
    var selectedImage: UIImage = UIImage.tintImage(image: #imageLiteral(resourceName: "image"))
    var unselectedImage: UIImage = UIImage.tintImage(image: #imageLiteral(resourceName: "image"))
    var isSelected = false
}
