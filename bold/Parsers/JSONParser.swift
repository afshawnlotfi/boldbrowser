//
//  JSONParser.swift
//  canis
//
//  Created by Afshawn Lotfi on 12/29/16.
//  Copyright © 2016 Afshawn Lotfi. All rights reserved.
//

import Foundation


class JSONParser{
    
    class func deserialize(data : Data) -> [String:Any] {
        var jsonDict = [String:AnyObject]()

        do{
            jsonDict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:AnyObject]
        
        } catch let error as NSError {
            print(error)
        }
        
        return jsonDict
        
    }
    
    class func serialize(dict : [String:Any]) -> Data{
        var jsonData = Data()
        
        
        do{
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
        } catch let error as NSError {
            print(error)
        }
        
        return jsonData
        
    }
}
