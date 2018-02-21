//
//  WorkspaceSlideManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class WorkspaceSlideManager:OptionSlideManager{
    
    var workspaceTitleLabel:UILabel{
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.System.Light
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerStack = UIStackView()
        let optionBtnStack = ButtonBarStack()
        let titleBtnStack = ButtonBarStack()
        
        titleBtnStack.axis = .vertical
        headerStack.axis = .vertical
        
        let padding = SizeConstants.Padding * 2
        let titleLabel = workspaceTitleLabel
        titleLabel.text = "#general"
        titleLabel.font = UIFont.systemFont(ofSize: padding)
        
        let descipLabel = workspaceTitleLabel
        descipLabel.text = "20 Posts"
        descipLabel.font = UIFont.systemFont(ofSize: SizeConstants.Padding)
        
        titleBtnStack.addItems(items: [titleLabel,descipLabel])
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "background-image")
        
        imageView.contentMode = .scaleAspectFit
        headerStack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        headerStack.isLayoutMarginsRelativeArrangement = true
        imageView.heightAnchor.constraint(equalToConstant: SizeConstants.Padding * 10).isActive = true
        headerStack.spacing = SizeConstants.Padding * 3
        headerStack.addArrangedSubview(imageView)
        headerStack.addArrangedSubview(optionBtnStack)
        imageView.addSubview(view: titleBtnStack, attributes: [.centerX,.centerY])
        optionBtnStack.addItems(items: [BlurButton(image: #imageLiteral(resourceName: "new-workspace")), BlurButton(image: #imageLiteral(resourceName: "image")) , BlurButton(image: #imageLiteral(resourceName: "delete"))])
        return headerStack
    }
    
    
}
