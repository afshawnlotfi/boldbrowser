//
//  BlurButton.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class BlurButton:UIButton{
    var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    init(image : UIImage? = nil, size : CGFloat = SizeConstants.StandardButton) {
        super.init(frame: CGRect())
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: SizeConstants.StandardButton + SizeConstants.Padding*2).isActive = true
        self.heightAnchor.constraint(equalToConstant: SizeConstants.Padding*2).isActive = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.widthAnchor.constraint(equalToConstant: size).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: size).isActive = true
        if let icon = image{
            self.setImage(icon.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        }
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = size*0.5
        if let imView = self.imageView{
            self.insertSubview(view: blurView, belowSubview: imView, attributes : [.centerX,.centerY])
        }
        
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

}


