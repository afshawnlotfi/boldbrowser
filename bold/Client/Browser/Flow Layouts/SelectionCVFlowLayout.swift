//
//  SelectionCVFlowLayout.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/23/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class SelectionCVFlowLayout:NSObject,UICollectionViewDelegateFlowLayout {
    
    private var sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10.0)
    
    
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
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
    
}
