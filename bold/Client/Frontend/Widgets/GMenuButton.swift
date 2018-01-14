//
//  GMenuButton.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol GMenuButtonDelegate{
    
    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults : IButtonDefaults)
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults : IButtonDefaults)

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
        self.widthConstraint = self.widthAnchor.constraint(equalToConstant: 38.0)
        self.widthConstraint.isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleAspectFit
        let selector = GSelector(target: self, selector: #selector(self.updateSelection))
        self.configureButton(selector: selector)
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func configureButton(title : String = String.empty, image : UIImage? = nil, isTinted : Bool = true, selector : GSelector? = nil){
        self.setTitle(title, for: .normal)
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
    


    
    
    /// Updates button selection
    ///
    /// - Parameter buttonDefaults: Button Defaults to update button from
    @objc func updateSelection(){
        if alternateSelection{
            if self.isSelected{
                self.isSelected = false
                gMenuButtonDelegate?.gMenuButton(didUnselectButton: self, buttonDefaults : self.buttonDefaults)
                self.configureButton(image: buttonDefaults.unselectedImage)
            }else{
                self.isSelected = true
                gMenuButtonDelegate?.gMenuButton(didSelectButton: self, buttonDefaults : self.buttonDefaults)
                self.configureButton(image: buttonDefaults.selectedImage)
                
            }
    
        }else{
            gMenuButtonDelegate?.gMenuButton(didSelectButton: self, buttonDefaults : self.buttonDefaults)
        }
    }
    

    
    
    
    
}


