//
//  FaviconManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/29/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit

class FaviconManager:ITabPluginScript{
    
    var pluginDescriptor: PluginScriptDescriptor
    private var storageManager = StorageManager<Favion>()
    private(set) var favicons:[Favion]
    private var storageDefaults = FaviconDefaults()
    var scriptContents: WKUserScript
    
    
    required init(pluginConfig: PluginScriptConfiguration) {
        pluginDescriptor = pluginConfig.pluginDescriptor
        scriptContents = pluginConfig.scriptContents
        favicons = storageManager.fetchObjects(fromDisk: true) as! [Favion]
    }
    

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        
        if let faviconURL:String = message.body as? String{
            storageDefaults.faviconURL = faviconURL
            if let url =  URL(string: faviconURL){
                storageDefaults.faviconData = UIImagePNGRepresentation(WebRequestManager.fetchImage(fetchURL: url))!
            }
            let favicon = storageManager.addObject(from: storageDefaults) as! Favion
            favicons.append(favicon)
            
        }
        
    }
    
    
    
    

    
}
