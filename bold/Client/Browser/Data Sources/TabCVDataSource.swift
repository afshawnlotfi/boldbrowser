//
//  TabCollectionViewDataSource.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class TabCVDataSource: NSObject, UICollectionViewDataSource{
    private var tabManager: TabManager!
    init(tabManager: TabManager) {
        super.init()
        self.tabManager = tabManager
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tabCollectionView = collectionView as? TabCollectionView{

        
            let tab = tabManager.tabs[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCollectionView.identifier, for: indexPath) as! GContainerCVCell
        
           cell.isSelected = true
           cell.indexPath = indexPath
        
        
                if tabCollectionView.tabFlowLayout.isMinimized == true{
                    cell.screenshotView.image = tab.screenshotImage
                    cell.titleMenu.isHidden = false
                    cell.minimizeCell()
                }else{
                    tab.createWebview()
                    tab.webView?.tag = indexPath.row
                    var withCurves = false
                    if tabCollectionView.tabFlowLayout.isTopMenuVisible{
                        withCurves = true
                    }
                    cell.maximizeCell(view: tab.webView, withCurves : withCurves)
                    

                }
                if let faviconURL = tab.faviconURL{
                    if let data = tabCollectionView.faviconManager.fetchFavicon(forUrl: faviconURL).faviconData{
                        if let image = UIImage(data: data){
                            cell.setCellImage(image: image)
                        }
                    }
                }
        
        
            cell.setCellTitle(title: tab.displayTitle)
        
            tabCollectionView.optionButtonManager.updateFocusOptions(gCell: cell, tab: tab)
                
                
                
            
            
            
            if indexPath.row == tabManager.tabs.count - 1{
                cell.alpha = 0
                UIView.animate(withDuration: 0.25, animations: {
                    cell.alpha = 1
                })
            }
        
            return cell

        }else{
            let cell = UICollectionViewCell()
            return cell
        }
        
        
    }
    

    func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
    
            return tabManager.tabs.count
    }
    
}
