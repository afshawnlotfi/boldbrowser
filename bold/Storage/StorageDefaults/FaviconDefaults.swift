//
//  FaviconDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/30/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

struct FaviconDefaults:ICDStorageDefaults{
    var faviconURL:String = String.empty
    var faviconData:Data = UIImagePNGRepresentation(#imageLiteral(resourceName: "webpage"))!
}
