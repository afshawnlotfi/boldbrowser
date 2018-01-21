//
//  SizeConstants.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/2/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct SizeConstants{
    
    static var MinimizedTab:CGSize{
      return CGSize(width: 170, height: 180)
    }
    static var TabTitleHeight:CGFloat{
        return 60
    }
    static var SliderStackWidth:CGFloat{
        return 300
    }
    
}


struct PageType{
    
    static var A4:CGSize{
        return CGSize(width: 595.0, height: 842.0)
    }
    static var B5:CGSize{
        return CGSize(width: 516.0, height: 729.0)

    }
}

    



struct TimeConstants{
    
    static let Animation:Double = 0.2
    static let ScreenShot:Double = 0.3
    static let Timeout:Double = 0.2
    static let Delay:Double = 1.0

}


struct CurveRadii{
    
    static let Standard:CGFloat = 10
    
}

struct AlphaValues{
    
    
    static let SliderStackCutoff:CGFloat = 0.8

}


