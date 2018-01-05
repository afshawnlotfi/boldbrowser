//
//  TabScrollManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit

protocol TabScrollManagerDelegate{
    
        func tabScrollManager(_ tabScrollManager : TabScrollManager, didShowTopMenu gesture: UIPanGestureRecognizer )
        func tabScrollManager(_ tabScrollManager : TabScrollManager, didHideTopMenu gesture: UIPanGestureRecognizer )
        func tabScrollManager(_ tabScrollManager : TabScrollManager, didShowTitleMenu gesture: UIPanGestureRecognizer)
        func tabScrollManager(_ tabScrollManager : TabScrollManager, didHideTitleMenu gesture: UIPanGestureRecognizer)

}



class TabScrollManager{
    
    var tabScrollDelegate:TabScrollManagerDelegate?
    var dismissTimer:Timer = Timer()
    
    @objc func tabScrollUpdated(_ gesture : UIPanGestureRecognizer) {
            let newScreenSize: CGRect = UIScreen.main.bounds
            let dragVelocity = gesture.velocity(in: gesture.view).y/10
            
            
            if (dragVelocity > (0.15 * newScreenSize.height)) {
                
                tabScrollDelegate?.tabScrollManager(self, didShowTitleMenu: gesture)
                
                
                if dragVelocity > (0.5 * newScreenSize.height) {
                    tabScrollDelegate?.tabScrollManager(self, didShowTopMenu: gesture)
                    dismissTimer.invalidate()
                    dismissTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                        self.tabScrollDelegate?.tabScrollManager(self, didHideTopMenu: gesture)
                    }
                }
            }else if dragVelocity < 0{
                tabScrollDelegate?.tabScrollManager(self, didHideTitleMenu: gesture)
                self.tabScrollDelegate?.tabScrollManager(self, didHideTopMenu: gesture)
            }
            
        }
}

