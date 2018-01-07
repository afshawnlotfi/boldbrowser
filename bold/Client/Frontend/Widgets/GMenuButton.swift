//
//  GMenuButton.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/6/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation
import UIKit

protocol GMenuButtonDelegate{
    
    func gMenuButton(didSelectButton button: GMenuButton, withDescriptor : [String : Any])
    func gMenuButton(didUnselectButton button: GMenuButton, withDescriptor : [String : Any])

}



class GMenuButton:UIButton{
    public var descriptorDict = [String:Any]()
    private var buttonDefaults:IButtonDefaults?
    public var gMenuButtonDelegate:GMenuButtonDelegate?
    private var widthConstraint = NSLayoutConstraint()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.System.Light, for: .normal)
        self.tintColor = UIColor.System.Light
        self.titleLabel?.textAlignment = .center
        self.widthConstraint = self.widthAnchor.constraint(equalToConstant: 38.0)
        self.widthConstraint.isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleAspectFit
    }
    
     convenience init(title : String = String.empty, image : UIImage? = nil, isTinted : Bool = true, selector : GSelector? = nil) {
        self.init()
        configureButton(title : title, image : image, isTinted : isTinted, selector : selector)

    }
    convenience init(buttonDefaults : IButtonDefaults) {
        self.init()
        self.buttonDefaults = buttonDefaults
        if buttonDefaults.isSelected{
            self.configureButton(image: buttonDefaults.selectedImage)
        }else{
            self.configureButton(image: buttonDefaults.unselectedImage)
        }
        self.isSelected = buttonDefaults.isSelected
        let selector = GSelector(target: self, selector: #selector(self.selectButton))
        self.configureButton(selector: selector)
        
    }
    

    
    func configureButton(title : String = String.empty, image : UIImage? = nil, isTinted : Bool = true, selector : GSelector? = nil){
        self.setTitle(title, for: .normal)
        if let icon = image{
            self.setImage(UIImage.tintImage(image: icon, isTinted: isTinted), for: .normal)
        }
        if let action = selector{
            self.removeTarget(nil, action: nil, for: .allEvents)
            self.addTarget(action.target, action:  action.selector, for: .touchUpInside)
        }
    }
    
  
    func scaleBtn(scale : Int){
        widthConstraint.constant = CGFloat(scale)
    }
    
    @objc func selectButton(){
        if let buttonDefaults = self.buttonDefaults{
            updateSelection(buttonDefaults: buttonDefaults)
        }
    }

    
    
    /// Updates button selection
    ///
    /// - Parameter buttonDefaults: Button Defaults to update button from
    func updateSelection(buttonDefaults : IButtonDefaults){
        if self.isSelected{
            self.isSelected = false
            gMenuButtonDelegate?.gMenuButton(didUnselectButton: self, withDescriptor : descriptorDict)
            self.configureButton(image: buttonDefaults.unselectedImage)
        }else{
            self.isSelected = true
            gMenuButtonDelegate?.gMenuButton(didSelectButton: self, withDescriptor : descriptorDict)
            self.configureButton(image: buttonDefaults.selectedImage)
            
        }
    }
    
    required convenience init(coder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
    
    
    
    
}


