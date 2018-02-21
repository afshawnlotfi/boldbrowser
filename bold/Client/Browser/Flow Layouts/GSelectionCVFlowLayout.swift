//
//  SelectionCVFlowLayout.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/23/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GSelectionCVFlowLayout:NSObject,UICollectionViewDelegateFlowLayout {
    
    private var sectionInsets = UIEdgeInsets(top: 0, left: SizeConstants.Padding, bottom: 0, right: SizeConstants.Padding)
    

    
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
        if let sCollectionView = collectionView as? SelectionCollectionView{
            let string = sCollectionView.selectionManager.items[indexPath.section][indexPath.row]
            return CGSize(width: string.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]).width + 50, height: 40)
        }else{
            return CGSize(width: 100, height: 40)
        }
    }
    
}
