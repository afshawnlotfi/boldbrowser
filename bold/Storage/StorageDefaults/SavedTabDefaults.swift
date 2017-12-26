//
//  SavedTabDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct SavedTabDefaults:IStorageDefaults{
    var title:String = BrowserStrings.NoTitle
    var faviconURL:String = BrowserStrings.NoTitle
    var sessionData:Data = TabSession.defaultData
}
