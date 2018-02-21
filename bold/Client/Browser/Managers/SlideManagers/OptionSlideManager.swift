//
//  OptionSlideManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


protocol SliderManagerDelegate{
    
    func requestSliderToClose()
    func sliderDidCloseFromDrag()

}
class OptionSlideManager:NSObject, SliderManagerDelegate{
  
    func requestSliderToClose() {
        sliderView.drawAway()
    }
    
    func sliderDidCloseFromDrag() {
        gMenuButton?.updateSelection(withCallback: false)
        
    }
    
    
    private(set) var bottomView:UIView?
    private var gMenuButton :GMenuButton?
    private let sliderView = SliderView()
    private(set) var selectionManager = SelectionManager<GMenuOption>()
    private(set) var optionFormatter:OptionTVCellFormatter
    private var gTVDataSource:GTVDataSource<GMenuOption>
    override init() {
        
        optionFormatter = OptionTVCellFormatter()
        gTVDataSource = GTVDataSource(selectionManager: selectionManager, cellFormatter: optionFormatter)
        super.init()
        sliderView.sliderManagerDelegate = self
        sliderView.tableView.dataSource = gTVDataSource
        sliderView.tableView.delegate = self

    }

    public func updateOptions(options : [[GMenuOption]]){
        selectionManager.items = options
        
        self.sliderView.tableView.reloadData()
    }

}



extension OptionSlideManager:GMenuButtonDelegate{

    func gMenuButton(didSelectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
        drawMenu(didSelectButton: button, buttonDefaults: buttonDefaults, index : index)

    }
    
    func gMenuButton(didUnselectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
        drawMenu(didSelectButton: button, buttonDefaults: buttonDefaults, index : index)
    }
    
    
    func drawMenu(didSelectButton button: GMenuButton, buttonDefaults: IButtonDefaults, index : Int) {
        self.gMenuButton = button
        if let optionButton = (buttonDefaults as? OptionButtonDefaults){
            if let optionSliderView = optionButton.optionSliderView as? TabWebView{
                self.bottomView = optionSliderView
            }
            if optionButton.isRightSide{
                sliderView.drawMenu(parentView: optionButton.optionSliderView, orientation: .right)
            }else{
                sliderView.drawMenu(parentView: optionButton.optionSliderView, orientation: .left)
            }
            
        }
    }
}





//TableView Adjustments
extension OptionSlideManager:UITableViewDelegate{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.empty
    }
}



