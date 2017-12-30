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
    
    func tabManager(didAddTab atIndex: IndexPath, tab: Tab) {
        self.reloadData()

    }
    
    func tabManager(didRemoveTab atIndex: IndexPath, tab: Tab) {
        self.reloadData()
    }
    
    func tabManager(didSelectTab atIndex: IndexPath, tab: Tab) {
        UIView.animate(withDuration: 0.1, animations: {
                self.contentOffset.x = UIScreen.main.bounds.width * CGFloat(atIndex.row)
        })
    }
    
    func tabManager(didUpdateTitle atIndex: IndexPath, tab: Tab) {
        if let cell = self.cellForItem(at: atIndex) as? GContainerCell{
            
            cell.setCellTitle(title: tab.displayTitle)
        }

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

