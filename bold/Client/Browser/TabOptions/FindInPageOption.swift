//
//  FindInPageOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class FindInPageOption:NSObject,TabOption,TabOptionDelegate,UITextFieldDelegate{
    
    public var sliderControllerDelegate:SliderCotrollerDelegate?
    private var toastView = GToastView()
    private var textfield = UITextField()
    private var forwardBtn = GMenuButton()
    private var backwardBtn = GMenuButton()
    private var totalMatches = 0
    private var current = 0
    private var webView:TabWebView?
    
    
    override init() {
        super.init()
        textfield.backgroundColor = UIColor.System.FadedWhite
        textfield.borderStyle = .roundedRect
        textfield.attributedPlaceholder = NSAttributedString(string: TabOptionStrings.FindInPage,
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.System.FadedWhite])
        toastView.setDismissSelector(selector: GSelector(target: self, selector: #selector(deactivateOption)) )
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(findText(_:)), for: .editingChanged)
        textfield.textColor = UIColor.System.Light
        forwardBtn.configureButton(image: #imageLiteral(resourceName: "arrow-right") , isTinted: true, selector: GSelector(target: self, selector: #selector(goForward)))
        backwardBtn.configureButton(image: #imageLiteral(resourceName: "arrow-left") , isTinted: true, selector: GSelector(target: self, selector: #selector(goBackward)))
    }
    
    func tabOption(didSelectCell cell: GTableViewCell, webView: TabWebView) {
        self.webView = webView
        activateOption()
    }

    @objc func findText(_ textfield : UITextField){
        let text = textfield.text!
        if text.count > 0 {
            
            webView?.evaluateJavaScript("hightlightAllOccurences('"+text+"');",
                    completionHandler: { (index, error) in
                    if let elementIndex =  index as? Int{
                            self.totalMatches = elementIndex
                    }else{
                            self.totalMatches = 0
                    }
            })
            
            
        }
    }
    
    
    @objc func goForward(){
        webView?.evaluateJavaScript("searchNext()",
                completionHandler: { (index, error) in
        if let elementIndex = index as? Int{
            self.current = elementIndex

        }
                    
                                                    
        })

        
    }
    
    @objc func goBackward(){
        webView?.evaluateJavaScript("searchPrev()",completionHandler: { (index, error) in
            
        if let elementIndex = index as? Int{
            self.current = elementIndex
                
        }
            
        })
    }
    
    
    func activateOption() {
        sliderControllerDelegate?.requestSliderToClose()
        if let webView = self.webView{
            toastView.showToast(view: webView)
        }
        textfield.becomeFirstResponder()
        toastView.addOptions(options: [textfield, backwardBtn, forwardBtn])
        toastView.setImage(image: #imageLiteral(resourceName: "search"))
        
    }
    
    @objc func deactivateOption() {
        self.webView?.evaluateJavaScript("removeHighlights()")

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        goForward()
        return true
        
    }
    
  
    
   
    
}
