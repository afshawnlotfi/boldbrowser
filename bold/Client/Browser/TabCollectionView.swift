//
//  TabCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 11/20/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class TabCollectionView: GCollectionView {

    
    private let identifier =  "GContainerCell"
    private var tabManager:TabManager


    
    init(tabManager : TabManager) {
        self.tabManager = tabManager
        super.init(identifier: identifier)
        self.dataSource = tabDataSource
        self.delegate = tabFlowLayout
        self.horizontalScroll(true)
        self.isPagingEnabled = true
        self.reloadData()

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tabDataSource: TabCollectionViewDataSource = {
        return  TabCollectionViewDataSource(identifier: identifier, tabManager: tabManager)
    }()
    
    private lazy var tabFlowLayout: TabCollectionViewFlowLayout = {
        return  TabCollectionViewFlowLayout()
    }()
    
    
}

