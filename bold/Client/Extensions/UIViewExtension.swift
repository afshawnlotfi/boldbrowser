//
//  ViewExtension.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/26/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    func screenshot() -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size , true, 1.0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let webViewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if let snapshot = webViewSnapShot{
            return snapshot
        }else{
            return UIImage()
        }
        
    }
}




extension UIView{
    
    
    func addSubview(view : UIView, attributes : [NSLayoutAttribute]) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()
        for attribute in attributes{
            let constaint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1.0, constant: 0.0)
            layoutConstraints.append(constaint)
        }
        self.addConstraints(layoutConstraints)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return layoutConstraints
    }
    
    
    
    
    
    
}
