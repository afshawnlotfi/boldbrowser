//
//  TabCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 11/20/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit


protocol TabCollectionViewDelegate {
    func tabCollectionView(_ tabCollectionView: TabCollectionView, didMaximizeCells atIndexPath: IndexPath)
    func tabCollectionView(_ tabCollectionView: TabCollectionView, didMinmizeCells atIndexPath: IndexPath)
}




class TabCollectionView: GCollectionView {
    
    private let bookmarkManager = BookmarkManager()
    private let identifier =  "GContainerCell"
    private var tabManager:TabManager
    private var startIndexPath:IndexPath?
    private(set) lazy var tabFlowLayout: TabCollectionViewFlowLayout = TabCollectionViewFlowLayout()
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
    
    
        
}



extension TabCollectionView{
    
    func updateTabBookmark(tab : Tab, atIndex: Int){
        var bookmarkDefault = BookmarkButtonDefaults()
        bookmarkDefault.isSelected = bookmarkManager.isBookmark(url: (tab.displayURL?.absoluteString)!)
        let bookmarkBtn = GMenuButton(buttonDefaults: bookmarkDefault)
        
        if let url = tab.displayURL?.absoluteString, let faviconURL = tab.favicon?.faviconURL{
            bookmarkBtn.descriptorDict = [
                
                "title" : tab.displayTitle,
                "url" : url,
                "faviconURL" : faviconURL
                
            ]
        }
        bookmarkBtn.gMenuButtonDelegate = bookmarkManager
        
        
        if let cell = self.cellForItem(at: IndexPath(row: atIndex, section: 0)) as? GCollectionContainerCell{

            cell.setOptionButtons(buttons: [bookmarkBtn])
            
        }
        
        
    }
    
    
}





extension TabCollectionView:GCollectionViewMoveDelegate{
    
    

    func gCollectionview(_ gCollectionview: GCollectionView, willSelectCell cell: UICollectionViewCell, atIndexPath: IndexPath) {

        startIndexPath = atIndexPath
        tabFlowLayout.tabCollectionViewDelegate?.tabCollectionView(self, didMinmizeCells: atIndexPath)

        if let gCell = cell as? GCollectionContainerCell{
            gCell.screenshotView.image = tabManager.tabs[atIndexPath.row].screenshotImage
            gCell.minimizeCell()
        }
    }
    
    func gCollectionview(_ gCollectionview: GCollectionView, didSelectCell cell: UICollectionViewCell, atIndexPath : IndexPath) {
       
        
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
        self.scrollToItem(at: IndexPath(row: atIndex, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: false)
    }
    
}


extension TabCollectionView:TabDelegate{
    
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView, atIndex: Int) {
        
        self.tabManager.configureWebview(tab: tab)
    }
    
    func tab(_ tab: Tab, didFinishLoading atIndex: Int) {
        updateTabBookmark(tab: tab, atIndex : atIndex )
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
    
    func tab(_ tab: Tab, didUpdateProgress webView: TabWebView, atIndex: Int) {

    }
    
}
    


