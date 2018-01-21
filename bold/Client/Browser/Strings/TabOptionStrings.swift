//
//  TabOptionStrings.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

struct TabOptionStrings{}

//All Options
extension TabOptionStrings{
    
    public static let FindInPage = NSLocalizedString("GTableViewCell.textLabel", value: "Find In Page", comment: "Find in page option title")
    public static let  DownloadPage = NSLocalizedString("GTableViewCell.textLabel", value: "Download Page", comment: "Download page option title")
    public static let  GeneratePDF = NSLocalizedString("GTableViewCell.textLabel", value: "Generate PDF", comment: "Generate PDF option title")
    public static let  Print = NSLocalizedString("GTableViewCell.textLabel", value: "Print", comment: "Print option title")
    public static let  NightMode = NSLocalizedString("GTableViewCell.textLabel", value: "Night Mode", comment: "Night Mode option title")

}


//PDF Options
extension TabOptionStrings{
    
    public static let PDFGenerationTypeTitle = NSLocalizedString("UIAlertAction.title", value: "What type of PDF would you like to generate?", comment: "PDF Type selection title")
    public static let PDFGenerationTypeMessage = NSLocalizedString("UIAlertAction.title", value: "Full Page (exactly how you would see it in the browser, without text selection) or Print Preview", comment: "PDF Type selection message")
    public static let PDFFullScreen = NSLocalizedString("UIAlertAction.title", value: "Full Page", comment: "PDF Type selection Fullscreen")
    public static let PDFPrintPreview = NSLocalizedString("UIAlertAction.title", value: "Print Preview", comment: "PDF Type selection Print Preview")

}


extension String{
    struct OptionStrings{
        
        static var OK:String{
            return "Okay"
        }
        static var Cancel:String{
            return "Cancel"
        }
        
    }
}
