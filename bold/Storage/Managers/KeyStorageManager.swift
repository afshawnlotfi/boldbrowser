//
//  KeyStorageManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/24/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

class KeyStorageManager{
    
    class func setValue(from defaults: IKeyStorageDefaults){
        let userDefaults = UserDefaults.standard
        print(defaults.key,defaults.value)
        userDefaults.set(defaults.value, forKey: defaults.key)
    }
    
    class func getValue(from defaults: IKeyStorageDefaults) -> String{
        let userDefaults = UserDefaults.standard
        print(defaults.key,defaults.value)
        if let value = userDefaults.string(forKey: defaults.key){
            return value
        }else{
            return String.empty
        }
    }
}
