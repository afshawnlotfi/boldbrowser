//
//  GSelectionCVCell.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/23/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol GSelectionCVCellDelegate {
    func gSelectionCVCell(_ gSelectionCVCell : GSelectionCVCell, didSelectCell atIndex : Int)
    func gSelectionCVCell(_ gSelectionCVCell : GSelectionCVCell, didDeselectCell atIndex : Int)
}

extension GIdentifierStrings{
    static let SelectionCVCell = "GSelectionCVCell"
}


class GSelectionCVCell: UICollectionViewCell {
    
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var titleBtn: UIButton!
    public var gSelectionCVCellDelegate:GSelectionCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        closeBtn.addTarget(self, action: #selector(deselectBtn), for: .touchUpInside)
        titleBtn.addTarget(self, action: #selector(selectBtn), for: .touchUpInside)
        self.layer.cornerRadius = CurveRadii.Standard
        self.closeBtn.imageView?.contentMode = .scaleAspectFit
        self.closeBtn.tintColor = UIColor.System.Light
        self.titleBtn.tintColor = UIColor.System.Light
    }
    
    func includeClose(isHidden : Bool){
        self.isHidden = isHidden
    }
    
    
    public func setTitle(title : String){
    
        titleBtn.setTitle(title, for: .normal)
    
    }
    
    @objc func deselectBtn(){
        print(self.tag)
        gSelectionCVCellDelegate?.gSelectionCVCell(self, didDeselectCell: self.tag)
    }
    
    @objc func selectBtn(){
        gSelectionCVCellDelegate?.gSelectionCVCell(self, didSelectCell: self.tag)
    }
}
