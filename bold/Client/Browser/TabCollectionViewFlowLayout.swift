//
//  TabCollectionViewFlowLayout.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/22/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit

class TabCollectionViewFlowLayout:NSObject,UICollectionViewDelegateFlowLayout {
    
    var isZoomedOut = false
    
    private var sectionInsets:UIEdgeInsets{
        if isZoomedOut{
            return  UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10.0)

        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    
    private func tabSize(sizeRatio:CGFloat) -> CGSize{
        if isZoomedOut{
            return CGSize.SizeConstants.MinimizedTab
            
        }else{
            return CGSize(width: UIScreen.main.bounds.width * sizeRatio, height: UIScreen.main.bounds.height*0.8)
        }
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
