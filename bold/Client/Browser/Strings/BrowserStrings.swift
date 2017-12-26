//
//  BrowserStrings.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct BrowserStrings{}

//Strings Pertaining to Browser Tab Bar
extension BrowserStrings{
    
    public static let NoTitle = NSLocalizedString("GContainerCell.titleButton.titleLabel", value: "No Title", comment: "Title given when all other descriptors are nil")
    public static let NewTab = NSLocalizedString("GContainerCell.titleButton.titleLabel", value: "New Tab", comment: "Title given for new tab")

    
}
//String Pertaining to Browser URLs
extension BrowserStrings{
    
    public static let NewTabURL = NSLocalizedString("GContainerCell.titleButton.titleLabel", value: "https://www.google.com", comment: "default URL for new tabs")
    
    
}

//Webview Observer Protocols
extension BrowserStrings{
    
    public static let LoadingObserver = NSLocalizedString("WebviewManager.observeValue", value: "loading", comment: "Observer to tell if webview is loading")
    public static let EstimatedProgressObserver = NSLocalizedString("WebviewManager.observeValue", value: "estimatedProgress", comment: "Observer to tell progress of webview")
    public static let URLObserver = NSLocalizedString("WebviewManager.observeValue", value: "URL", comment: "Observer to tell when webview changes URL")
    public static let TitleObserver = NSLocalizedString("WebviewManager.observeValue", value: "title", comment: "Observer to tell when webview changes title")

}












