//
//  SavedTabDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct SavedTabDefaults:IStorageDefaults{
    var index: Int
    init(startIndex : Int) {
        index = startIndex
    }
    var title:String = BrowserStrings.NoTitle
    var faviconURL:String = String()
    var sessionData:Data = TabSession.defaultData
}
