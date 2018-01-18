//
//  WebSourceObject.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/15/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

class WebSourceObject{
    
    private(set) var url = String()
    private(set) var html = String()
    private(set) var js = [String]()
    private(set) var css = [String]()

    init(url : String , html : String , js : [String], css : [String]) {
        self.url = url
        self.html = html
        self.js = js
        self.css = css
        
    }
}
