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
    
    
    class func fetchData(fetchURL : URL) -> Data {
        let semaphore = DispatchSemaphore(value: 0);
        var webResponse = Data()
        
            let request = NSMutableURLRequest(url: fetchURL)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                webResponse = data!
                (semaphore).signal()
            }
            
            task.resume()
            semaphore.wait()
        
        
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

