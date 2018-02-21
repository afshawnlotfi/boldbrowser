//
//  WebRequestManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/30/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit

class WebRequestManager{
    
    
    class func fetchData(fetchURL : URL, headers : [String : String]? = nil,  parameters : [String : Any]? = nil, httpMethod : String) -> Data {
        var webResponse = Data()
        if DeviceInfo.hasConnectivity(){
            
            let semaphore = DispatchSemaphore(value: 0);
            let request = NSMutableURLRequest(url: fetchURL, cachePolicy: .useProtocolCachePolicy,
                                                                       timeoutInterval: TimeConstants.Request)
                
                
            request.httpMethod = httpMethod
            
            if let lheaders = headers{
                request.allHTTPHeaderFields = lheaders
            }
            
            
            if let lparameters = parameters{
                do{
                    let postData = try JSONSerialization.data(withJSONObject: lparameters, options: [])
                    request.httpBody = postData
                }catch{
                
                }
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error == nil) {
                    if let webData = data{
                        webResponse = webData
                    }
                    (semaphore).signal()
                }
            })
            
            dataTask.resume()
            semaphore.wait()
        
        }
        
        return webResponse
    }
    
    class func fetchImage(fetchURL : URL) -> UIImage {
        do{
            let data = try Data(contentsOf: fetchURL)
            if let image = UIImage(data: data){
                return image
            }else{
                return #imageLiteral(resourceName: "image")
            }
        }catch{
            return #imageLiteral(resourceName: "image")

        }
    }
}

