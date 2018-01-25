//
//  SelectionCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/23/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class SelectionCollectionView : GCollectionView, GSelectionCVCellDelegate{
    
    init() {
        super.init(identifier: GIdentifierStrings.SelectionCVCell)
        
        self.dataSource = selectionDataSource
        self.delegate = hashtagFlowLayout
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    private lazy var selectionDataSource: SelectionCVDataSource = {
        return  SelectionCVDataSource()
    }()
    
    private lazy var hashtagFlowLayout: SelectionCVFlowLayout = {
        return  SelectionCVFlowLayout()
    }()
    
    
    func gSelectionCVCell(_ gSelectionCVCell: GSelectionCVCell, didSelectCell atIndex: Int) {
        
    }
    
    func gSelectionCVCell(_ gSelectionCVCell: GSelectionCVCell, didDeselectCell atIndex: Int) {
        selectionDataSource.removeItem(atIndex: atIndex)
        self.deleteItems(at: [indexPath(for: gSelectionCVCell)!])
        for (index,visibleCell) in self.visibleCells.enumerated(){
            visibleCell.tag = index
        }
    }
    
}
