//
//  WebsiteObjectDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


struct WebsiteObjectDefaults:IStorageDefaults{
    var faviconURL:String =  String.empty
    var url:String = String.empty
    var title:String = BrowserStrings.NoTitle
}
