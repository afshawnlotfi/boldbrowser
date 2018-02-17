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
        
        if let webView = tab.webView{
            let optionsDefault = OptionButtonDefaults(webView: webView)
            let optionViewBtn = GMenuButton(buttonDefaults: optionsDefault)
            optionViewBtn.gMenuButtonDelegate = tabOptionManager
            gCell.setOptionButtons(buttons: [bookmarkBtn,optionViewBtn])

        }else{
            gCell.setOptionButtons(buttons: [bookmarkBtn])
        }

        
        
        
        
        
        
    }
    
    
    
    
    
    
}



