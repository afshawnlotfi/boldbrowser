//
//  BoldWebServiceManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/7/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


class BoldWebServiceManager{
    
    
    func searchHashtags(fromKeyword : String, atWebsite : String) -> [String]{
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
        ]
        let parameters = [
            "query": fromKeyword,
            "url": "https://google.com"
            ] as [String : Any]
        



        let data = WebRequestManager.fetchData(fetchURL: URL(string: WebServiceInfo.url + "suggest")!, headers: headers, parameters: parameters, httpMethod: HTTPRequest.POST)
        let json = JSONParser.deserialize(data: data)

        if let predicted = json["predicted_suggestions"] as? [String]{
            return predicted
        }else{
            return []
        }
        

        
    }
    
    func suggestHashtags(fromKeyword : String) {
        
        
        
        
    }
    
    
    
    
}
