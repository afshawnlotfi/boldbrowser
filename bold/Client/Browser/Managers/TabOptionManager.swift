//
//  TabOptionManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit



class DefaultTabSliderOptions:NSObject{
    
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


protocol SliderCotrollerDelegate{
    
    func requestSliderToClose()
    
}
class TabOptionManager:NSObject, SliderCotrollerDelegate{
  
    func requestSliderToClose() {
        sliderView.drawAway()
    }
 

    private var tabWebView:TabWebView?
    private let sliderView = SliderView()
    private(set) var optionFormatter:OptionTVCellFormatter
    private var gTVDataSource:GTVDataSource<GMenuOption>
    override init() {
        optionFormatter = OptionTVCellFormatter()
        gTVDataSource = GTVDataSource(cellFormatter: optionFormatter)
        super.init()
        sliderView.tableView.dataSource = gTVDataSource
        sliderView.tableView.delegate = self
    }
    
    public func updateOptions(options : [[GMenuOption]]){
        self.gTVDataSource.items = options
        self.sliderView.tableView.reloadData()
    }
    
}



extension TabOptionManager:GMenuButtonDelegate{

    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults: IButtonDefaults) {
        if let optionButton = (buttonDefaults as? OptionButtonDefaults){
            if let webView = optionButton.tab.webView{
                sliderView.drawMenu(parentView: webView, orientation: .right)
                tabWebView = webView
            }
        }
    }
    
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults: IButtonDefaults) {
        
    }
}





//TableView Adjustments
extension TabOptionManager:UITableViewDelegate{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        let option = gTVDataSource.items[indexPath.section][indexPath.row]
        if let gCell = tableView.cellForRow(at: indexPath) as? GTableViewCell, let webView = self.tabWebView{
            option.delegate?.tabOption(didSelectCell: gCell, webView: webView)

        }
    }
}



