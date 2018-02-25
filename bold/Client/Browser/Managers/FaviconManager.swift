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
    
    private let storageManager = StorageManager<Favicon>()
 
 
    init() {
        self.storageManager.fetchObjects(fromDisk: true)
    }
    
   
    
    /// Fetches favicon for url
    ///
    /// - Parameter forUrl: url to search favicon for
    /// - Returns: returns resulting favicon data
    func fetchFavicon(forUrl : String) -> Favicon{
        let favicons = storageManager.fetchObjects(fromDisk: false)  
        let matchingFavicons = (favicons.filter{ $0.faviconURL == forUrl})
        if matchingFavicons.count == 0{
            return Favicon.DefaultFavicon(faviconURL: BrowserStrings.NewTabURL, faviconData: UIImagePNGRepresentation(#imageLiteral(resourceName: "webpage"))!)
        }else{
            return matchingFavicons[0]
        }
    }
    
    

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var storageDefaults = FaviconDefaults()
        
        if let webView = message.webView as? TabWebView{

            if let faviconURL:String = message.body as? String{
                if DeviceInfo.hasConnectivity(){
                    storageDefaults.faviconURL = faviconURL
                    if let url =  URL(string: faviconURL){
                        let image = WebRequestManager.fetchImage(fetchURL: url)
                        storageDefaults.faviconData = UIImagePNGRepresentation(image)!
                    }
                    
                    let matchingIndecies = ((self.storageManager.fetchObjects(fromDisk: false) ).filter{ $0.faviconURL == faviconURL})

                    if matchingIndecies.count == 0{
                        self.storageManager.addObject(from: storageDefaults)
                    }else{
                        self.storageManager.updateObject(updatedValues: ["faviconData" : storageDefaults.faviconData], object: matchingIndecies[0])
                        
                    }
                }
                    
                webView.setValue(faviconURL, forKey: KVOConstants.faviconURL)

            }
        }
        
        
    }
    
    
    
    

    
}
