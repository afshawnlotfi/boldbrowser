//
//  SavedTabDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/23/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct SavedTabDefaults:IStorageDefaults{
    var index: Int
    init(startIndex : Int) {
        index = startIndex
    }
    var title:String = BrowserStrings.NewTab
    var faviconURL:String = String.empty
    var sessionData:Data = TabSession.defaultData
    var screenshotData:Data = UIImagePNGRepresentation(UIImage.blockImage(color: .white, size: SizeConstants.MinimizedTab))!
}
