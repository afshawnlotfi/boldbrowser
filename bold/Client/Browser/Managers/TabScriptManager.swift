//
//  TabScriptManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit


class TabScriptManager: NSObject, WKScriptMessageHandler {
    
    private var scriptPool = [String : ITabPluginScript]()
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //Search for plugin identifier
        for script in scriptPool.values {
            if script.pluginDescriptor.isValid == true && script.pluginDescriptor.messageHandlerName == message.name {
                script.userContentController(userContentController, didReceive: message)
                break
            }
        }
    }
    
    func addTabScript(tabScript : ITabPluginScript , atTab tab : Tab){
        if tabScript.pluginDescriptor.isValid == true{
            //Add tabScript to dictionary
            scriptPool[tabScript.pluginDescriptor.messageHandlerName] = tabScript
            let handlerName = tabScript.pluginDescriptor.messageHandlerName
            tab.webView?.configuration.userContentController.add(self, name: handlerName)
            tab.webView?.configuration.userContentController.addUserScript(tabScript.scriptContents)

        }
    }
    
    
    func retrieveTabScript(handlerMessageName name: String) -> ITabPluginScript? {
        return scriptPool[name]
    }
    
    
}




