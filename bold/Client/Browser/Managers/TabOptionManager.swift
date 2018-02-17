//
//  TabOptionManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


protocol SliderCotrollerDelegate{
    
    func requestSliderToClose()
    
}
class TabOptionManager:NSObject, SliderCotrollerDelegate{
  
    func requestSliderToClose() {
        sliderView.drawAway()
    }
 

    private var tabWebView:TabWebView?
    private let sliderView = SliderView()
    private var selectionManager = SelectionManager<GMenuOption>()
    private(set) var optionFormatter:OptionTVCellFormatter
    private var gTVDataSource:GTVDataSource<GMenuOption>
    override init() {
        optionFormatter = OptionTVCellFormatter()
        gTVDataSource = GTVDataSource(selectionManager: selectionManager, cellFormatter: optionFormatter)
        super.init()
        sliderView.tableView.dataSource = gTVDataSource
        sliderView.tableView.delegate = self

    }

    public func updateOptions(options : [[GMenuOption]]){
        selectionManager.items = options
        
        self.sliderView.tableView.reloadData()
    }

}



extension TabOptionManager:GMenuButtonDelegate{

    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
        if let optionButton = (buttonDefaults as? OptionButtonDefaults){
            if let webView = optionButton.optionView as? TabWebView{
                tabWebView = webView
            }
            sliderView.drawMenu(parentView: optionButton.optionView, orientation: .right)

        }
    }
    
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
        
    }
}





//TableView Adjustments
extension TabOptionManager:UITableViewDelegate{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.empty
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        let option = selectionManager.items[indexPath.section][indexPath.row]
        if let gCell = tableView.cellForRow(at: indexPath) as? GTableViewCell, let webView = self.tabWebView{
            option.delegate?.tabOption(didSelectCell: gCell, webView: webView)

        }
    }
}



