//
//  URLArrayExtension.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/25/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation

extension String{
    
    func convertToURL() -> URL{
        
        return URL(string : self)!
    }
    
}

