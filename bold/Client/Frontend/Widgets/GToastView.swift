//
//  ToastView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/10/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class GToastView:UIVisualEffectView{
    private var contentStack = UIStackView()
    private var descriptorIcon = GMenuButton()
    private var optionStack = UIStackView()
    private var dismissSelector:GSelector?
    private var removeFromViewBtn = GMenuButton()
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        self.effect = UIBlurEffect(style: .dark)
        self.contentStack.addArrangedSubview(descriptorIcon)
        self.contentStack.addArrangedSubview(optionStack)
        self.contentStack.spacing = 10
        self.contentView.addSubview(view: self.contentStack, attributes: [.bottom,.top,.left,.right])
        self.heightAnchor.constraint(equalToConstant: SizeConstants.TabTitleHeight).isActive = true
        contentStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentStack.isLayoutMarginsRelativeArrangement = true
        removeFromViewBtn.configureButton(image: #imageLiteral(resourceName: "close-circled"), isTinted: true, selector: GSelector(target: self, selector: #selector(dismissFromScreen)))
    }
    
    
    func setSpacing(spacing : CGFloat){
        
        optionStack.spacing = spacing
        
    }
    
    func addOptions(options : [UIView]){
        
        self.optionStack.arrangedSubviews.forEach{
            self.optionStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        options.forEach{
            self.optionStack.addArrangedSubview($0)
        }
        self.optionStack.addArrangedSubview(self.removeFromViewBtn)
    }
    

    
    func setDismissSelector(selector : GSelector){
        self.dismissSelector = selector
    }
    
    func setImage(image : UIImage){
        descriptorIcon.configureButton(image: image, isTinted: true)
    }
    
    func showToast(view : UIView){
        
        let attribute = NSLayoutAttribute.top

      
        self.alpha = 0
        view.addSubview(view: self, attributes: [.left,.right,attribute])
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        })
    }
    
    @objc func dismissFromScreen(){
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: {finished in
            
            self.removeFromSuperview()
            
        })
        if let selector = dismissSelector{
           _ = selector.target.perform(selector.selector)
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {

        self.init(effect: UIBlurEffect(style: .dark))
    
    }
    
}
