//
//  GSelector.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


class GSelector:NSObject{
    private(set) var target:AnyObject
    private(set) var selector:Selector
    
    init(target : AnyObject, selector : Selector) {
        self.target = target
        self.selector = selector
        super.init()
    }
    
}
