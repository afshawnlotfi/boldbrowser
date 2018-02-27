//
//  ITabOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


@objc protocol SliderOptionDelegate{

    @objc optional func sliderOption(didSelectCell cell: GTableViewCell, webView : TabWebView)
    
    @objc optional func sliderOption(didSelectCell cell: GTableViewCell)

}

protocol SliderOption{
    func activateOption()
    func deactivateOption()
}
