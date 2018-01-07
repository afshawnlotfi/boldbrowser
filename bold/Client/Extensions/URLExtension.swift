//
//  URLExtension.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

extension URL{
    
    static var empty:URL{
        return URL(string: BrowserStrings.NewTabURL)!
    }
    
}
