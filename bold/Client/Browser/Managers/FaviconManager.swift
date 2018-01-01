//
//  FaviconManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/29/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit

class FaviconManager:ITabPluginManager{
    
    private static var storageManager = StorageManager<Favicon>()
    private var storageDefaults = FaviconDefaults()
 
 
    init() {
        _ = FaviconManager.storageManager.fetchObjects(fromDisk: true)
    }
    
   
    
    class func retrieveFavicon(forUrl : String) -> Favicon{
        let favicons = storageManager.fetchObjects(fromDisk: false)  as! [Favicon]
        let matchingFavicons = (favicons.filter{ $0.faviconURL == forUrl})
        return matchingFavicons[0]
    }
    
    

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let webView = message.webView as? TabWebView{

            if let faviconURL:String = message.body as? String{
                storageDefaults.faviconURL = faviconURL
                if let url =  URL(string: faviconURL){
                    storageDefaults.faviconData = UIImagePNGRepresentation(WebRequestManager.fetchImage(fetchURL: url))!
                }
                
                let matchingIndecies = ((FaviconManager.storageManager.dataObjects as! [Favicon]).filter{ $0.faviconURL == faviconURL})

                if matchingIndecies.count == 0{
                    _ = FaviconManager.storageManager.addObject(from: storageDefaults)
                }else{
                    FaviconManager.storageManager.updateObject(updatedValues: [ObserverStrings.FaviconObserver : storageDefaults.faviconURL, "faviconData" : storageDefaults.faviconData], object: matchingIndecies[0])

                }
                    
                webView.setValue(faviconURL, forKey: ObserverStrings.FaviconObserver)

            }
        }
        
        
    }
    
    
    
    

    
}
