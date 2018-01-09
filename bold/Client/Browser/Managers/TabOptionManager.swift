//
//  TabOptionManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class TabOptionManager:NSObject{
    
    
    private var findInPageOption = FindInPageOption()
    private var tabWebView:TabWebView?
    private var options:[[GMenuOption]]
    private let sliderView = SliderView()
    
    
    override init() {
        options = [
            [
                GMenuOption(title: TabOptionStrings.FindInPage, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "findinpage")), delegate : findInPageOption),
                GMenuOption(title: TabOptionStrings.DownloadPage, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "download"))),
                GMenuOption(title: TabOptionStrings.GeneratePDF, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "generate-pdf"))),
                GMenuOption(title: TabOptionStrings.Print, icon: UIImage.tintImage(image: #imageLiteral(resourceName: "print")))
                
            ],
            [
                GMenuOption(title: TabOptionStrings.NightMode, includeSwitch: true)
            ]
            
        ]
        super.init()
        sliderView.tableView.dataSource = self
        sliderView.tableView.delegate = self
       
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

//Data Source of Slide View
extension TabOptionManager:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sliderView.tableView.identifier, for: indexPath) as! GTableViewCell
        let option = options[indexPath.section][indexPath.row]
        
        if (option.includeSwitch){
            cell.addSwitch(isOn: false)
        }
        
        cell.backgroundColor = .clear
        
        cell.textLabel?.text = option.title
        if let icon = option.icon{
            cell.imageView?.image = icon
        }
        return cell
    }
    
}

//TableView Adjustments
extension TabOptionManager:UITableViewDelegate{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        let option = options[indexPath.section][indexPath.row]
        if let gCell = tableView.cellForRow(at: indexPath) as? GTableViewCell, let webView = self.tabWebView{
            option.delegate?.tabOption(didSelectCell: gCell, webView: webView)

        }

    }

}



