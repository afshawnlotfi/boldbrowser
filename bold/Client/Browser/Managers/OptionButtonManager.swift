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
    let tabOptionManager = TabOptionManager()


    
    
    func updateOptionButtons(gCell : GContainerCVCell, tab : Tab){
        

        
        var bookmarkDefault = BookmarkButtonDefaults(tab: tab)
        bookmarkDefault.isSelected = bookmarkManager.isBookmark(url: (tab.displayURL?.absoluteString)!)
        let bookmarkBtn = GMenuButton(buttonDefaults: bookmarkDefault)
        bookmarkBtn.alternateSelection = true
        bookmarkBtn.gMenuButtonDelegate = bookmarkManager

        let optionsDefault = OptionButtonDefaults(tab: tab)
        let optionViewBtn = GMenuButton(buttonDefaults: optionsDefault)
        optionViewBtn.gMenuButtonDelegate = tabOptionManager
        
        
        
        gCell.setOptionButtons(buttons: [bookmarkBtn,optionViewBtn])
            
        
        
    }
    
    
    
    
    
    
}



