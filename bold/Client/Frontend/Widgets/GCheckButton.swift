//
//  GCheckButton.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GCheckButton: GMenuButton{
    private let checkDefaults = CheckButtonDefaults()
    
    init() {
        super.init(buttonDefaults: checkDefaults)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
