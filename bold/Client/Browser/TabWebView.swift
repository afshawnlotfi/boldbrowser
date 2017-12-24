//
//  TabWebView.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class TabWebView:WKWebView{
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration:  configuration)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.allowsBackForwardNavigationGestures = true
        self.allowsLinkPreview = false
    }
    
    required init?(coder: NSCoder) {
        self.init()
    }
    
    
    
}


