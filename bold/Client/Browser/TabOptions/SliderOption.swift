//
//  ITabOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


protocol SliderOptionDelegate{

    func sliderOption(didSelectCell cell: GTableViewCell, webView : TabWebView)

}

protocol SliderOption{
    func activateOption()
    func deactivateOption()
}
