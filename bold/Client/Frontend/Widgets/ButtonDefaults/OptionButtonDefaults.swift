//
//  OptionButtonDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct OptionButtonDefaults:IButtonDefaults{
    let optionSliderView:UIView!
    init(view : UIView){
        optionSliderView = view
    }
    
    var isRightSide = true
    var selectedImage: UIImage = #imageLiteral(resourceName: "more")
    var unselectedImage: UIImage = #imageLiteral(resourceName: "more")
    var isSelected = false
    
}
