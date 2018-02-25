//
//  OptionButtonManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/7/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class OptionButtonManager{
    
    
    private let bookmarkManager = BookmarkManager()
    private let tabSliderOptions = TabSliderOptions()

    private var tabOptionManager = TabSlideManager()

    init(){
        
        tabOptionManager.updateOptions(options: tabSliderOptions.options)
        tabSliderOptions.findInPageOption.sliderControllerDelegate = tabOptionManager
        tabSliderOptions.pdfPageOption.sliderControllerDelegate = tabOptionManager
        
        
    }
    
    

    
    func updateOptionButtons(gCell : GContainerCVCell, tab : Tab){
        

        
        var bookmarkDefault = BookmarkButtonDefaults(tab: tab)
        bookmarkDefault.isSelected = bookmarkManager.isBookmark(url: (tab.displayURL?.absoluteString)!)
        let bookmarkBtn = GMenuButton(buttonDefaults: bookmarkDefault)
        bookmarkBtn.alternateSelection = true
        bookmarkBtn.gMenuButtonDelegate = bookmarkManager
        
        if let webView = tab.webView{
            let optionsDefault = OptionButtonDefaults(view: webView)
            let optionViewBtn = GMenuButton(buttonDefaults: optionsDefault)
            optionViewBtn.gMenuButtonDelegate = tabOptionManager
            gCell.setOptionButtons(buttons: [bookmarkBtn,optionViewBtn])

        }else{
            gCell.setOptionButtons(buttons: [bookmarkBtn])
        }
        
        
    }
    
}



