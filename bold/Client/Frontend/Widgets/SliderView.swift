//
//  SliderStackView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/7/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//


import UIKit

class SliderView:UIStackView{
    private var optionViewSlider = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var backDropView = UIView()
    private var isRightSide = false
    private var isSliderDrawn = false
    private var panGesture = UIPanGestureRecognizer()
    private var focusTapGesture = UITapGestureRecognizer()
    private var sliderConstraints = [NSLayoutConstraint]()
    private(set) var tableView:GTableView = GTableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backDropView.backgroundColor = UIColor.System.Dark
        self.addGestureRecognizer(panGesture)
        backDropView.addGestureRecognizer(focusTapGesture)
        panGesture.addTarget(self, action: #selector(panGestureAction(_:)))
        focusTapGesture.addTarget(self, action: #selector(drawAway))
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        optionViewSlider.contentView.addSubview(view: tableView, attributes: [.left,.right,.top,.bottom])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        optionViewSlider.widthAnchor.constraint(equalToConstant: SizeConstants.SliderStackWidth).isActive = true
        
        self.addArrangedSubview(self.optionViewSlider)
        self.addArrangedSubview(self.backDropView)

        
        
    }
    
    
    
    
    func drawMenu(parentView : UIView, orientation : NSLayoutAttribute){
 
            parentView.removeConstraints(sliderConstraints)
        
            sliderConstraints = parentView.addSubview(view: self, attributes: [.left,.right,.top,.bottom])
        
            switch orientation{
                case NSLayoutAttribute.right:
                    isRightSide = true
                default:
                    isRightSide = false
            }
            
            if isSliderDrawn{
                drawAway()
            }else{
                drawForward()
            }
        
        
    }
    
        
        
        
        
        
        
    
    
    @objc func panGestureAction(_ gesture : UIPanGestureRecognizer){
        

        
        if gesture.state == .changed{
            
            var factor = CGFloat(SizeConstants.SliderStackWidth)
            if isRightSide == true{
                factor = CGFloat(-SizeConstants.SliderStackWidth)
            }
            
            self.alpha = 1 + gesture.translation(in: self).x / factor
            
            
        }
        
        
        if gesture.state == .ended{
            if isRightSide == false{
                
                if self.alpha > AlphaValues.SliderStackCutoff || gesture.velocity(in: self).x > 0{
                    
                    drawForward()

                    
                }else{
                    drawAway()
                }
            }else{
                
                if self.alpha > AlphaValues.SliderStackCutoff || gesture.velocity(in: self).x < 0{
                    drawForward()

                }else{
                    drawAway()
                }
                
            }
            
            
        }
        
        
    }
    
    
    func drawForward(){

        if isSliderDrawn == false{
            self.isHidden = false
            self.alpha = 0
            switch self.isRightSide{
            case true:
                
                self.insertArrangedSubview(backDropView, at: 0)
                self.insertArrangedSubview(optionViewSlider, at: 1)
                
            case false:
                self.insertArrangedSubview(backDropView, at: 1)
                self.insertArrangedSubview(optionViewSlider, at: 0)
            }
            isSliderDrawn = true

        }

        
        UIView.animate(withDuration: TimeConstants.Animation, animations: {
            self.alpha = 1
            self.optionViewSlider.isHidden = false
            
        })
        
    }
    
    @objc func drawAway(){
        UIView.animate(withDuration: TimeConstants.Animation, animations: {
            self.alpha = 0
            
        }, completion: {finished in
            
            self.isHidden = true
        })
        isSliderDrawn = false

        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

