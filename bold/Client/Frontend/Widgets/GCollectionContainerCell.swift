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
    @IBOutlet weak var urlField: UITextField!
    private var previousViews:[UIView] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        urlField.textColor = UIColor.System.Light
        blurView.effect = UIBlurEffect(style: .dark)
        urlField.isEnabled = false
        faviconBtn.imageView?.contentMode = .scaleAspectFit
//        titleField.addTarget(self, action: #selector(searchMenu(_:)), for: .editingDidBegin)
//        titleField.addTarget(self, action: #selector(searchMenu(_:)), for: .editingChanged)

    }
    
    @objc func searchMenu(_ textfield : UITextField){
        let view = UIView()
        transitionTo(view: view)
        textfield.text = String()
    }
    
    public func minimizeCell(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 10
            self.blurViewHeight.constant = 45
            self.layoutIfNeeded()
        })
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
        UIView.animate(withDuration: 0.2, animations: {
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
