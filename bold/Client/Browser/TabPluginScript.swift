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



protocol ITabPluginManager{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
}


/// Class that validates and configures scripts
class TabPluginScript:NSObject{
    private(set) var pluginDescriptor:PluginScriptDescriptor
    private(set) var scriptContents:WKUserScript
    private(set) var manager:ITabPluginManager

    /// Function that validates plugin config
    ///
    /// - Parameter pluginName: Name of the Plugin
    /// - Returns: Script Object
    init(pluginName : String, manager : ITabPluginManager){
        var scriptName = String.empty
        var messageHandler = String.empty
        var isValid = false
        var sScript = String.empty
        self.manager = manager
        let configPath = Bundle.main.path(forResource: "config", ofType: "json", inDirectory: "JS/Plugins/" + pluginName)
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: configPath!), options: .mappedIfSafe)
            let jsonResult = JSONParser.deserialize(data: data)
                if let name = jsonResult["name"] as? String {
                    if let handler = jsonResult["handler"] as? String {
                        isValid = true
                        scriptName = name
                        messageHandler = handler
                        let configPath = Bundle.main.path(forResource: scriptName, ofType: "js", inDirectory: "JS/Plugins/" + scriptName)
                        
                        do{
                            sScript = try String(contentsOf: URL(fileURLWithPath: configPath!), encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                        }catch{
                            sScript = String.empty
                        }
                        
                        
                    }
                }
            
        }catch{
            fatalError(ErrorStrings.PluginConfig)
        }
        
        pluginDescriptor = PluginScriptDescriptor(scriptName: scriptName, messageHandlerName: messageHandler, isValid: isValid)
        scriptContents = WKUserScript(source: sScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        super.init()

    }

    
    
}







