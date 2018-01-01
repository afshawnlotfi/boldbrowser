//
//  TabCollectionViewDataSource.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit

class TabCollectionViewDataSource: NSObject, UICollectionViewDataSource{
  
    private(set) var identifier: String
    private(set) var tabManager: TabManager!
    
    init(identifier : String, tabManager: TabManager) {
        self.identifier = identifier
        super.init()
        self.tabManager = tabManager
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tab = tabManager.tabs[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GContainerCell
        tab.createWebview()
        tab.webView?.tag = indexPath.row
        cell.setContentView(view: tab.webView!)
        cell.setCellTitle(title: tab.displayTitle)
        if let faviconImage = UIImage(data : (tab.favicon?.faviconData)!){
                cell.setCellImage(image: faviconImage)
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
    
            return tabManager.tabs.count
    }
    
}
