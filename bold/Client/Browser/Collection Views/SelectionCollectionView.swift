//
//  SelectionCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/23/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class SelectionCollectionView : GCollectionView, GSelectionCVCellDelegate{
    private(set) var selectionManager = SelectionManager<String>()
    init() {
        super.init(identifier: GIdentifierStrings.SelectionCVCell)
        self.delegate = selectionFlowLayout
        self.dataSource = selectionDataSource
        self.showsHorizontalScrollIndicator = false

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func includeClose(_ include: Bool){
        self.selectionDataSource.includeClose = include
    }
    
    private lazy var selectionDataSource: SelectionCVDataSource = {
        return  SelectionCVDataSource(selectionManager: selectionManager)
    }()
    
    private lazy var selectionFlowLayout: GSelectionCVFlowLayout = {
        return  GSelectionCVFlowLayout()
    }()
    
    func gSelectionCVCell(_ gSelectionCVCell: GSelectionCVCell, didSelectCell atIndex: Int) {
        
    }
    
    func gSelectionCVCell(_ gSelectionCVCell: GSelectionCVCell, didDeselectCell atIndex: Int) {
        if let indexPath = self.indexPath(for: gSelectionCVCell){
            
            selectionDataSource.removeItem(index: indexPath.row)

            for (index,cell) in self.visibleCells.enumerated(){
                cell.tag = index
            }
        
        }

    }
    
}
