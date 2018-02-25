//
//  GLabel.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GLabel:UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            self.textColor = UIColor.System.Light
            self.textAlignment = .center
            self.font = UIFont.systemFont(ofSize: 20)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
    
    
}
