//
//  ErrStrings.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct ErrorStrings{}


//Errors Pertaining to Plugins
extension ErrorStrings{
    
    public static let PluginConfig = NSLocalizedString("PluginScriptValidator.fatalError", value: "Plugin Configuration Error ", comment: "Error when plugin configuration file formatting is invalid")

    
}

//Errors Pertaining to Core Data
extension ErrorStrings{
    
    public static let FetchError = NSLocalizedString("StorageManager.fatalError", value: "Core Data Fetch Error ", comment: "Error when Core Data does not return back object")

    
}


