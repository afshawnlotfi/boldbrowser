//
//  TabSliderOptions.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/11/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class TabSliderOptions:NSObject{
    
    let findInPageOption = FindInPageOption()
    let downloadPageOption = DownloadPageOption()
    let pdfPageOption = PDFPagePageOption()
    
    private(set) var options:[[GMenuOption]]
    override init() {
        options = [
            [
                GMenuOption(title: SliderOptionStrings.FindInPage, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "findinpage")), delegate : findInPageOption),
                GMenuOption(title: SliderOptionStrings.DownloadPage, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "download")), delegate : downloadPageOption),
                GMenuOption(title: SliderOptionStrings.GeneratePDF, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "generate-pdf")), delegate : pdfPageOption),
                GMenuOption(title: SliderOptionStrings.Print, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "print")))
                
            ],
            [
                GMenuOption(title: SliderOptionStrings.NightMode, includeSwitch: true)
            ]
        ]
        super.init()
        
    }
    
}
