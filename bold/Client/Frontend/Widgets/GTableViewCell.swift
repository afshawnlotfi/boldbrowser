//
//  GTableViewCell.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/8/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol GTabelViewSwitchDelegate{
    
    func gTableViewCell(_ gTableViewCell : GTableViewCell, didTurnOnSwitch switch: UISwitch)
    func gTableViewCell(_ gTableViewCell : GTableViewCell, didTurnOffSwitch switch: UISwitch)

    
}


extension GIdentifierStrings{
    
    static let TableViewCell = "GTableViewCell"
    
}


class GTableViewCell: UITableViewCell {

    private lazy var cellSwitch = UISwitch()
    public var switchDelegate:GTabelViewSwitchDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.textColor = UIColor.System.Light
        self.imageView?.tintColor = UIColor.System.Light
    }
    
    func addSwitch(isOn : Bool){

        self.accessoryView = cellSwitch
        cellSwitch.removeTarget(nil, action: nil, for: .allEvents)
        cellSwitch.addTarget(self, action: #selector(switchStateChange(_:)), for: .valueChanged)
        cellSwitch.isOn = isOn
    }
    
    @objc func switchStateChange( _ sender : UISwitch){

        switch sender.isOn{
            
            case true:
                switchDelegate?.gTableViewCell(self, didTurnOnSwitch: sender)
            case false:
                switchDelegate?.gTableViewCell(self, didTurnOffSwitch: sender)
            
        }
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
