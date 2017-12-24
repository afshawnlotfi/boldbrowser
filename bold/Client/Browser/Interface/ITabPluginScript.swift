//
//  ITabScript.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit


/// Object that contains script configuration information
class PluginScriptDescriptor{
    private(set) var scriptName: String
    private(set) var messageHandlerName: String
    private(set) var isValid: Bool
    init(scriptName sName: String, messageHandlerName mName: String, isValid isTrue: Bool){
        scriptName = sName
        messageHandlerName = mName
        isValid = isTrue
    }
}


/// Class that validates scripts
class PluginScriptValidator{
    
    /// Function that validates plugin config
    ///
    /// - Parameter pluginName: Name of the Plugin
    /// - Returns: Script Object
    class func validateConfig(pluginName : String) -> PluginScriptDescriptor{
        var scriptName = String()
        var messageHandler = String()
        var isValid = false
        let configPath = Bundle.main.path(forResource: pluginName, ofType: "js")
        do {
            let pluginConfig = try String(contentsOf: URL(fileURLWithPath: configPath!), encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            let parsedData = try JSONSerialization.jsonObject(with: pluginConfig.data(using: .utf8)!, options: []) as! Dictionary<String,AnyObject>
            if let name = parsedData["name"] as? String {
                if let handler = parsedData["handler"] as? String {
                    isValid = true
                    scriptName = name
                    messageHandler = handler
                    
                }
            }
        }catch{
            
            fatalError(ErrorStrings.PluginConfig)
            
        }
        
        return PluginScriptDescriptor(scriptName: scriptName, messageHandlerName: messageHandler, isValid: isValid)

    }
}



protocol ITabPluginScript {
    init(pluginName : String)
    var pluginDescriptor:PluginScriptDescriptor {get set}
    func userContentController(_ userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage)
}



