//
//  DeviceInfo.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/17/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit
open class DeviceInfo {
    
    open class func hasConnectivity() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .online(.wwan), .online(.wiFi):
            return true
        default:
            return false
        }
    }
}
