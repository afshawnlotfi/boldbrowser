//
//  ViewExtension.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/26/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit


extension UIView{
    
    func screenshot() -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size , true, 1.0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if let snapshot = snapshot{
            return snapshot
        }else{
            return UIImage()
        }
        
    }
}


extension UIView{
    static var empty:UIView{
        return UIView()
    }
}

extension UIView{
    
    
    @discardableResult func addSubview(view : UIView, attributes : [NSLayoutAttribute]) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        for attribute in attributes{
            let constaint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1.0, constant: 0.0)
            layoutConstraints.append(constaint)
        }
        self.addConstraints(layoutConstraints)

        return layoutConstraints
    }
    
    
}
