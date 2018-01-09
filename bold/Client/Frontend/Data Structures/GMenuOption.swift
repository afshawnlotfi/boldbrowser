//
//  GMenuOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class GMenuOption{
    private(set) var title = String.empty
    private(set) var icon:UIImage?
    private(set) var selector:GSelector?
    private(set) var delegate:TabOptionDelegate?
    private(set) var includeSwitch:Bool = false
    init(title : String? = nil, icon : UIImage? = nil, selector:GSelector? = nil, includeSwitch : Bool = false, delegate : TabOptionDelegate? = nil) {
        if let menuTitle = title{
            self.title = menuTitle
        }
        if let menueIcon = icon{
            self.icon = menueIcon
        }
        
        if let menuSelector = selector{
            self.selector = menuSelector
        }
        
        if let menuDelegate = delegate{
            self.delegate = menuDelegate
        }
        
        self.includeSwitch = includeSwitch
    }
    
    
}
