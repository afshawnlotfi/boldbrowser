//
//  TabSelectionCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 3/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

class TabSelectionCollectionView:SelectionCollectionView{
    
    override init() {
        super.init()
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.horizontalScroll(true)
        self.selectionManager.items = [["Tabs","Tags"]]
    }
    
}
