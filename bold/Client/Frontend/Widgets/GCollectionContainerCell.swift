//
//  GContainerCell.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GCollectionContainerCell: UICollectionViewCell {

    @IBOutlet weak var blurViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var contentStack: UIStackView!
    @IBOutlet private weak var optionStack: UIStackView!
    @IBOutlet private weak var faviconBtn: UIButton!
    private(set) var screenshotView = UIImageView()

    
    @IBOutlet weak var urlField: UITextField!
    private var previousViews:[UIView] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        urlField.textColor = UIColor.System.Light
        blurView.effect = UIBlurEffect(style: .dark)
        urlField.isEnabled = false
        faviconBtn.imageView?.contentMode = .scaleAspectFit
        screenshotView.contentMode = UIViewContentMode.scaleAspectFill
        screenshotView.clipsToBounds = true
        screenshotView.isUserInteractionEnabled = false


    }
    
    @objc func searchMenu(_ textfield : UITextField){
        let view = UIView()
        transitionTo(view: view)
        textfield.text = String()
    }
    
    public func minimizeCell(with contentView : UIView){
        UIView.animate(withDuration: AnimationTimeConstants.fast, animations: {
            self.layer.cornerRadius = CurveRadii.standard
            self.blurViewHeight.constant = 45
            self.urlField.font = .systemFont(ofSize: 14)
            self.layoutIfNeeded()
        })
        self.setContentView(view: contentView)
    }
    
    public func maximizeCell(with contentView : UIView){
        UIView.animate(withDuration: AnimationTimeConstants.fast, animations: {
            self.blurViewHeight.constant = 55
            self.urlField.font = .systemFont(ofSize: 17)
            self.layoutIfNeeded()
        })
        self.setContentView(view: contentView)
    }
    

    
    
    /// Set the cells container title
    ///
    /// - Parameter title: Name of title
    public func setCellTitle(title : String){
        urlField.text = title
    }
    
    
    /// Set the cell container image
    ///
    /// - Parameter image: Image of container
    public func setCellImage(image : UIImage){
        faviconBtn.setImage(image, for: .normal) 
    }
    
    
    /// Transitions to View
    ///
    /// - Parameter view: View to transition to
    public func transitionTo(view : UIView){
        view.alpha = 0
        UIView.animate(withDuration: AnimationTimeConstants.fast, animations: {
            self.contentStack.arrangedSubviews.forEach{ $0.alpha = 0}
            self.setContentView(view: view)
            view.alpha = 1
        })
    }
    
    
    /// Set content view of container
    ///
    /// - Parameter view: View inside container
    public func setContentView(view : UIView){
        previousViews = []
        contentStack.arrangedSubviews.forEach{previousViews.append($0); contentStack.removeArrangedSubview($0); $0.removeFromSuperview()}
        contentStack.addArrangedSubview(view)
    
    }

}
