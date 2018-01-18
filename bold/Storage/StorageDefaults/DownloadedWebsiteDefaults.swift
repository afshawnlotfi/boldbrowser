//
//  DownloadedWebsiteDefaults.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/15/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct DownloadedWebsiteDefaults:IStorageDefaults{
    var url:String = String.empty
    var data:Data = Data()

    init(url : String, data : Data){
        self.url = url
        self.data = data
    }
    
}
