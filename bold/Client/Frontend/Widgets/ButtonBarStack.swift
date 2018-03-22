//
//  ButtonBarStack.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class ButtonBarStack: UIStackView {
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 1
    }
    
    func addItems(items : [UIView]){
        
        
        for item in items{
            
            item.tintColor = UIColor.System.Light
            self.addArrangedSubview(item)
            
        }
        
    }
    
    required convenience init(coder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
    
}
