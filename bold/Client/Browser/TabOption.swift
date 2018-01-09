//
//  ITabOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


protocol TabOptionDelegate{

    func tabOption(didSelectCell cell: GTableViewCell, webView : TabWebView)
    
}

protocol TabOption{
    func activateOption()
    func deactivateOption()
}
