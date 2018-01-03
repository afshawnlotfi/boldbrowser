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
    private var startIndexPath:IndexPath?

    init(tabManager : TabManager) {
        self.tabManager = tabManager
        super.init(identifier: identifier)
        self.dataSource = tabDataSource
        self.delegate = tabFlowLayout
        self.tabManager.tabManagerDelegates.append(self)
        self.horizontalScroll(true)
        self.moveDelegate = self
        self.isPagingEnabled = true
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
extension TabCollectionView:GCollectionViewMoveDelegate{
    func gCollectionview(_ gCollectionview: GCollectionView, didSelectCell cell: UICollectionViewCell, atIndexPath : IndexPath) {
        startIndexPath = atIndexPath
        tabFlowLayout.isZoomedOut = true
        self.horizontalScroll(false)
        self.isPagingEnabled = false
        if let gCell = cell as? GCollectionContainerCell{
            gCell.minimizeCell()
        }
    }
    
    func gCollectionview(_ gCollectionview: GCollectionView, didMoveCell cell: UICollectionViewCell, atIndexPath : IndexPath) {
        
    }
    
    func gCollectionview(_ gCollectionview: GCollectionView, didReleaseCell cell: UICollectionViewCell, atIndexPath : IndexPath) {
        self.tabManager.moveTab(current: (startIndexPath?.row)!, final: atIndexPath.row)
    }
    

}


extension TabCollectionView:TabManagerDelegate{
    
    func tabManager(_ tabManager: TabManager, didAddTab tab: Tab, atIndex: Int) {
        tabManager.tabs[atIndex].tabDelegate = self
        self.reloadData()
        
    }
    
    func tabManager(_ tabManager: TabManager, didRemoveTab tab: Tab, atIndex: Int) {
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, didSelectTab tab: Tab, atIndex: Int) {
        UIView.animate(withDuration: 0.1, animations: {
            self.contentOffset.x = UIScreen.main.bounds.width * CGFloat(atIndex)
        })
    }
    
}


extension TabCollectionView:TabDelegate{
    
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView, atIndex: Int) {
        
        let faviconManager = FaviconManager()
        let faviconPlugin = TabPluginScript(pluginName: "favicon", manager: faviconManager)
        
        self.tabManager.addObserver(tab: tab, observerKeys: [KVOConstants.estimatedProgress,KVOConstants.title,KVOConstants.faviconURL, KVOConstants.URL, KVOConstants.loading])
        
        
        self.tabManager.addTabPluginScripts(tab: tab, tabScripts: [faviconPlugin])
        tab.restoreWebview(webView)
    }
    
    func tab(_ tab: Tab, didFinishLoading atIndex: Int) {
        tab.webView?.evaluateJavaScript("getFavicons()")
    }
    
    func tab(_ tab: Tab, didUpdateTitle title: String, atIndex: Int) {
        if let cell = self.cellForItem(at: IndexPath(row: atIndex, section: 0)) as? GCollectionContainerCell{
            cell.setCellTitle(title: title)
        }
    }
    
    func tab(_ tab: Tab, didUpdateFavicon favicon: Favicon, atIndex: Int) {
        if let cell = self.cellForItem(at: IndexPath(row: atIndex, section: 0)) as? GCollectionContainerCell{
            cell.setCellImage(image: UIImage(data: favicon.faviconData!)! )
        }
    }
}
    


