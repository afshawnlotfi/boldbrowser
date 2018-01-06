//
//  GContainerCell.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GCollectionContainerCell: UICollectionViewCell {

    @IBOutlet private weak var blurViewHeight: NSLayoutConstraint!
    @IBOutlet private(set) weak var titleMenu: UIVisualEffectView!
    @IBOutlet private weak var contentStack: UIStackView!
    @IBOutlet private weak var optionStack: UIStackView!
    @IBOutlet private weak var faviconBtn: UIButton!
    public var indexPath:IndexPath?
    @IBOutlet weak var screenshotView: UIImageView!
    @IBOutlet weak var urlField: UITextField!
    private var previousViews:[UIView] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        urlField.textColor = UIColor.System.Light
        titleMenu.effect = UIBlurEffect(style: .dark)
        urlField.isEnabled = false
        faviconBtn.imageView?.contentMode = .scaleAspectFit
        screenshotView.contentMode = .scaleAspectFill
        screenshotView.clipsToBounds = true
        screenshotView.isUserInteractionEnabled = false
        screenshotView.backgroundColor = .red
        self.isSelected = false

    }
    
    @objc func searchMenu(_ textfield : UITextField){
        let view = UIView()
        transitionTo(view: view)
        textfield.text = String()
    }
    
    public func minimizeCell(){

        UIView.animate(withDuration: TimeConstants.animation, animations: {
            self.layer.cornerRadius = CurveRadii.standard
            self.blurViewHeight.constant = 45
            self.urlField.font = .systemFont(ofSize: 14)
            self.layoutIfNeeded()
        })

        
        screenshotView.isHidden = false
        contentStack.isHidden = true

    }
    
    public func maximizeCell(view : UIView? = nil, withCurves: Bool){
        UIView.animate(withDuration: TimeConstants.animation, animations: {
            self.blurViewHeight.constant = 55
            if withCurves{
                self.layer.cornerRadius = CurveRadii.standard
            }else{
                self.layer.cornerRadius = 0
            }
            self.urlField.font = .systemFont(ofSize: 17)
            self.layoutIfNeeded()
        })
        screenshotView.isHidden = true
        contentStack.isHidden = false

        if view != nil{
            self.setContentView(view: view!)
        }
        
        
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
        UIView.animate(withDuration: TimeConstants.animation, animations: {
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
