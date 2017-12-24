//
//  GContainerCell.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GContainerCell: UICollectionViewCell {

    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var contentStack: UIStackView!
    @IBOutlet private weak var optionStack: UIStackView!
    @IBOutlet private weak var titleBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleBtn.setTitleColor(ColorConfiguration.SystemLight, for: .normal)
        blurView.effect = ColorConfiguration.SystemBlur
    }
    
    
    /// Set the cells container title
    ///
    /// - Parameter title: Name of title
    public func setCellTitle(title : String){
        titleBtn.setTitle(title, for: .normal)
    }
    
    
    /// Set the cell container image
    ///
    /// - Parameter image: Image of container
    public func setCellImage(image : UIImage){
        titleBtn.setImage(image, for: .normal)
    }
    
    
    /// Set content view of container
    ///
    /// - Parameter view: View inside container
    public func setContentView(view : UIView){
        contentStack.arrangedSubviews.forEach{contentStack.removeArrangedSubview($0); $0.removeFromSuperview()}
        contentStack.addArrangedSubview(view)
    
    }

}
