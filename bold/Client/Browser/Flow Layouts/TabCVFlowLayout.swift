//
//  TabCollectionViewFlowLayout.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/22/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class TabCVFlowLayout:NSObject,UICollectionViewDelegateFlowLayout {
    var tabCollectionViewDelegate:TabCollectionViewDelegate?
    private(set) var isMinimized:Bool = false
    private(set) var isTopMenuVisible:Bool = false
    private(set) var isTitleMenuVisible:Bool = true

    private var sectionInsets:UIEdgeInsets{
        if isMinimized == true{
            return  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10.0)

        }else{
            var spacingInset = 0
            if isTopMenuVisible == true{
                spacingInset = Int(SizeConstants.TabTitleHeight*2)
            }
                if isTitleMenuVisible == true{
                    return UIEdgeInsets(top: CGFloat(120 + spacingInset), left: 0, bottom: 0, right: 0)

                }else{
                    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }

        }
    }
    
    
    /// Updates collection insets based pm parameters
    ///
    /// - Parameters:
    ///   - isMinimized: Tells if the tab is minimized
    ///   - isTopMenuVisible: Tells if the top menu is showing
    ///   - isTabTitleVisible: Tells if the title view is showing
    func updateCollectionViewInsets(isMinimized : Bool? = nil ,isTopMenuVisible : Bool? = nil, isTitleMenuVisible: Bool? = nil ){
        if isMinimized != nil{
            self.isMinimized = isMinimized!
        }

        if isTopMenuVisible != nil{
            self.isTopMenuVisible = isTopMenuVisible!
        }
        
        if isTitleMenuVisible != nil{
            self.isTitleMenuVisible = isTitleMenuVisible!
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tabCollectionView = collectionView as? TabCollectionView{
            tabCollectionViewDelegate?.tabCollectionView(tabCollectionView, didMaximizeCells: indexPath)
        }
    }
    
    
    
    private func tabSize(sizeRatio:CGFloat) -> CGSize{
        if isMinimized{
            return SizeConstants.MinimizedTab
            
        }else{
            return CGSize(width: UIScreen.main.bounds.width * sizeRatio, height: UIScreen.main.bounds.height + SizeConstants.TabTitleHeight*2)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.isSelected = false
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return tabSize(sizeRatio: CGFloat(1.0))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    
    
    
    
}




