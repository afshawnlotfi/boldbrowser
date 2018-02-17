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
                GMenuOption(title: TabOptionStrings.FindInPage, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "findinpage")), delegate : findInPageOption),
                GMenuOption(title: TabOptionStrings.DownloadPage, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "download")), delegate : downloadPageOption),
                GMenuOption(title: TabOptionStrings.GeneratePDF, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "generate-pdf")), delegate : pdfPageOption),
                GMenuOption(title: TabOptionStrings.Print, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "print")))
                
            ],
            [
                GMenuOption(title: TabOptionStrings.NightMode, includeSwitch: true)
            ]
        ]
        super.init()
        
    }
    
}
