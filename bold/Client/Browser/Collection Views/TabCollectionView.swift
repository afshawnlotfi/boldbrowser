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
    let optionButtonManager = OptionButtonManager()
    private var tabManager:TabManager
   
    //Built In Plugins
    let faviconManager = FaviconManager()
    private let downloadManager = DownloadManager()
    private let tabSliderOptions = TabSliderOptions()
    
    private var builtInScripts = [TabPluginScript]()
    private var startIndexPath:IndexPath?
    private(set) lazy var tabFlowLayout: TabCVFlowLayout = TabCVFlowLayout()
    init(tabManager : TabManager) {
        self.tabManager = tabManager
        super.init(identifier: GIdentifierStrings.ContainerCVCell)
        self.dataSource = tabDataSource
        self.delegate = tabFlowLayout
        self.optionButtonManager.tabDelegate = self
        //Built in scripts
        builtInScripts = [
            TabPluginScript(pluginName: "favicon", manager: faviconManager),
            TabPluginScript(pluginName: "download", manager: downloadManager),
            TabPluginScript(pluginName: "find")
        ]
        
        downloadManager.downloadManagerDelegate = tabSliderOptions.downloadPageOption
        
        self.tabManager.tabManagerDelegates.append(self)
        self.horizontalScroll(true)
        self.moveDelegate = self
        self.isPagingEnabled = true
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private lazy var tabDataSource: TabCVDataSource = {
        return  TabCVDataSource(tabManager: tabManager)
    }()
    
}

extension TabCollectionView:GCollectionViewMoveDelegate{
    
    

    func gCollectionview(_ gCollectionview: GCollectionView, willSelectCell cell: UICollectionViewCell, atIndexPath: IndexPath) {

        startIndexPath = atIndexPath
        tabFlowLayout.tabCollectionViewDelegate?.tabCollectionView(self, didMinmizeCells: atIndexPath)

        if let gCell = cell as? GContainerCVCell{
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
    func tabManager(_ tabManager: TabManager, updateTabs tabs: [Tab]) {
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, didAddTab tab: Tab, atIndex: Int) {
        tabManager.tabs[atIndex].tabDelegate = self
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, didRemoveTab tab: Tab, atIndex: Int) {
        self.deleteItems(at: [IndexPath(row: atIndex, section: 0)])
        self.reloadData()
    }
    
    func tabManager(_ tabManager: TabManager, didSelectTab tab: Tab, atIndex: Int) {
        self.scrollToItem(at: IndexPath(row: atIndex, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: false)
    }
    
}





extension TabCollectionView:TabDelegate{
    
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView, atIndex: Int) {
        
        self.tabManager.configureWebview(tab: tab, plugins: builtInScripts)

    }
    
    func tab(willDeleteTab atIndex: Int) {
        tabManager.deleteTab(atIndex: atIndex)
    }
    
    func tab(_ tab: Tab, didFinishLoading atIndex: Int) {
        
    }
    
    func tab(_ tab: Tab, didUpdateTitle title: String, atIndex: Int) {
        if let cell = self.cellForItem(at: IndexPath(row: atIndex, section: 0)) as? GContainerCVCell{
            cell.setCellTitle(title: title)
        }
    }
    
    func tab(_ tab: Tab, didUpdateFaviconURL faviconURL: String, atIndex: Int) {
        
        let favicon = faviconManager.fetchFavicon(forUrl: faviconURL)
        tab.faviconURL = faviconURL
        tab.favicon = favicon

        if let cell = self.cellForItem(at: IndexPath(row: atIndex, section: 0)) as? GContainerCVCell{
            cell.setCellImage(image: UIImage(data: favicon.faviconData!)! )
        }
    }
    
    func tab(_ tab: Tab, didUpdateProgress webView: TabWebView, atIndex: Int) {

    }
    
}
    


