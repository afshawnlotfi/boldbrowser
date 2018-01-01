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
        self.tabManager.tabManagerDelegates.append(self)
        self.horizontalScroll(true)
        self.isPagingEnabled = true
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tabManager(_ tabManager: TabManager, didAddTab atIndex: IndexPath, tab: Tab) {
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, didRemoveTab atIndex: IndexPath, tab: Tab) {
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, didSelectTab atIndex: IndexPath, tab: Tab) {
        UIView.animate(withDuration: 0.1, animations: {
            self.contentOffset.x = UIScreen.main.bounds.width * CGFloat(atIndex.row)
        })
    }
    
    func tabManager(_ tabManager: TabManager, didUpdateTitle atIndex: IndexPath, title: String) {
        if let cell = self.cellForItem(at: atIndex) as? GContainerCell{
            cell.setCellTitle(title: title)
        }
    }
    
    
    func tabManager(_ tabManager: TabManager, didUpdateFaviconURL atIndex: IndexPath, faviconURL: String) {
        if let cell = self.cellForItem(at: atIndex) as? GContainerCell{
            if let data =  FaviconManager.retrieveFavicon(forUrl: faviconURL).faviconData{
                if let faviconImage = UIImage(data : data){
                    cell.setCellImage(image: faviconImage)
                }
            }
        }
    }
    
    private lazy var tabDataSource: TabCollectionViewDataSource = {
        return  TabCollectionViewDataSource(identifier: identifier, tabManager: tabManager)
    }()
    
    private lazy var tabFlowLayout: TabCollectionViewFlowLayout = {
        return  TabCollectionViewFlowLayout()
    }()
        
}

