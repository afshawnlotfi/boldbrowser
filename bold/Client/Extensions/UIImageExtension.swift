//
//  ImageExtension.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit


extension UIImage{
    
    class func blockImage(color : UIColor, size : CGSize ) -> UIImage{
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(imageRect)
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            return image
        }else{
            return UIImage()
        }
    }
    
    
    
    class func cropImage(image:UIImage, size : CGSize) -> UIImage{
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        if let cgImage = image.cgImage!.cropping(to: imageRect){
            return UIImage(cgImage:cgImage)
        }else{
            return image
        }
    }
    
}
