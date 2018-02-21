//
//  GMenuButton.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol GMenuButtonDelegate{
    
    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults : IButtonDefaults, index : Int)
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults : IButtonDefaults,  index : Int)

}



class GMenuButton:UIButton{
    public var descriptorDict = [String:Any]()
    private(set) var buttonDefaults:IButtonDefaults = GenericButtonDefaults()
    public var gMenuButtonDelegate:GMenuButtonDelegate?
    private var widthConstraint:NSLayoutConstraint!
    public var alternateSelection = false
    init(buttonDefaults defaults : IButtonDefaults? = nil) {
        super.init(frame: CGRect.zero)

        if let buttonDefaults = defaults{
            self.buttonDefaults = buttonDefaults

            if buttonDefaults.isSelected{
                self.configureButton(image: buttonDefaults.selectedImage)
            }else{
                self.configureButton(image: buttonDefaults.unselectedImage)
            }
            
            self.isSelected = buttonDefaults.isSelected
        }
        self.setTitleColor(UIColor.System.Light, for: .normal)
        self.tintColor = UIColor.System.Light
        self.titleLabel?.textAlignment = .center
        self.widthConstraint = self.widthAnchor.constraint(equalToConstant: SizeConstants.StandardButton)
        self.widthConstraint.isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleAspectFit
        let selector = GSelector(target: self, selector: #selector(self.updateButton))
        self.configureButton(selector: selector)
    }
    

    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func configureButton(buttonDefaults : IButtonDefaults){
        self.buttonDefaults = buttonDefaults
        self.configureButton(image: self.buttonDefaults.unselectedImage)

    }

    
    func configureButton(title : String? = nil, image : UIImage? = nil, isTinted : Bool = true, selector : GSelector? = nil){
        if title != nil{
            self.setTitle(title, for: .normal)
        }
        if let icon = image{
            var iconNew = icon
            if isTinted{
                iconNew = UIImage.tintImage(image: icon)
            }
            self.setImage(iconNew, for: .normal)
        }
        if let action = selector{
            self.removeTarget(nil, action: nil, for: .allEvents)
            self.addTarget(action.target, action:  action.selector, for: .touchUpInside)
        }
    }
    
  
    func scaleBtn(scale : Int){
        widthConstraint.constant = CGFloat(scale)
    }
    

    @objc private func updateButton(){
        updateSelection(withCallback : true)
    }
    
    
    /// Updates button selection
    ///
    /// - Parameter buttonDefaults: Button Defaults to update button from
    func updateSelection(withCallback : Bool){
        if alternateSelection{
            if self.isSelected{
                self.isSelected = false
                if withCallback{
                    gMenuButtonDelegate?.gMenuButton(didUnselectButton: self, buttonDefaults : self.buttonDefaults, index : self.tag)
                }
                self.configureButton(image: buttonDefaults.unselectedImage)
            }else{
                self.isSelected = true
                if withCallback{
                    gMenuButtonDelegate?.gMenuButton(didSelectButton: self, buttonDefaults : self.buttonDefaults, index : self.tag)
                }
                self.configureButton(image: buttonDefaults.selectedImage)
                
            }
    
        }else{
            gMenuButtonDelegate?.gMenuButton(didSelectButton: self, buttonDefaults : self.buttonDefaults, index : self.tag)
        }
    }
    

    
    
    
    
}


