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

    @IBOutlet weak var faviconBtn: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        urlTextField.textColor = ColorConfiguration.SystemLight
        blurView.effect = ColorConfiguration.SystemBlur
        
    }
    
    
    /// Set the cells container title
    ///
    /// - Parameter title: Name of title
    public func setCellTitle(title : String){
        urlTextField.text = title
    }
    
    
    /// Set the cell container image
    ///
    /// - Parameter image: Image of container
    public func setCellImage(image : UIImage){
        faviconBtn.setImage(image, for: .normal) 
    }
    
    
    /// Set content view of container
    ///
    /// - Parameter view: View inside container
    public func setContentView(view : UIView){
        contentStack.arrangedSubviews.forEach{contentStack.removeArrangedSubview($0); $0.removeFromSuperview()}
        contentStack.addArrangedSubview(view)
    
    }

}
