//
//  TabCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 11/20/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class TabCollectionView: GCollectionView,TabManagerDelegate {

    
    private let identifier =  "GContainerCell"
    private var tabManager:TabManager

    init(tabManager : TabManager) {
        self.tabManager = tabManager
        super.init(identifier: identifier)
        self.dataSource = tabDataSource
        self.delegate = tabFlowLayout
        self.horizontalScroll(true)
        self.isPagingEnabled = true
        tabManager.tabManagerDelegates.append(self)
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, addTab at : IndexPath) {
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, selectedTab at: IndexPath) {
        UIView.animate(withDuration: 0.1, animations: {
            self.contentOffset.x = UIScreen.main.bounds.width * CGFloat(at.row)
        })
    }
    
    func tabManager(_ tabManager: TabManager, removeTab at: IndexPath) {
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

