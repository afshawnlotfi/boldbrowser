//
//  FaviconDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/30/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit

struct FaviconDefaults:IStorageDefaults{
    var faviconURL:String = BrowserStrings.NewTabURL
    var faviconData:Data = UIImagePNGRepresentation(#imageLiteral(resourceName: "webpage"))!
}
