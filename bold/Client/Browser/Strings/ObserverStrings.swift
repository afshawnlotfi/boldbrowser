//
//  ObserverStrings.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/30/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct ObserverStrings{}


extension ObserverStrings{
    
    public static let LoadingObserver = NSLocalizedString("WebviewManager.observeValue", value: "loading", comment: "Observer to tell if webview is loading")
    public static let EstimatedProgressObserver = NSLocalizedString("WebviewManager.observeValue", value: "estimatedProgress", comment: "Observer to tell progress of webview")
    public static let URLObserver = NSLocalizedString("WebviewManager.observeValue", value: "URL", comment: "Observer to tell when webview changes URL")
    public static let TitleObserver = NSLocalizedString("WebviewManager.observeValue", value: "title", comment: "Observer to tell when webview changes title")
    public static let FaviconObserver = NSLocalizedString("WebviewManager.observeValue", value: "faviconURL", comment: "Observer to tell when webview favicon url changes")
    
}
