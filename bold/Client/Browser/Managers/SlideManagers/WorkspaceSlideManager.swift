//
//  WorkspaceSlideManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class WorkspaceSlideManager:OptionSlideManager{
    private let titleLabel = GLabel()
    private let descipLabel =  GLabel()

    private var workspaceStorageManager:StorageManager<Workspace>
    init(gMenuButton : GMenuButton, workspaceStorageManager : StorageManager<Workspace>) {
        self.workspaceStorageManager = workspaceStorageManager
        super.init(gMenuButton : gMenuButton)

        gMenuButton.alternateSelection = true
        gMenuButton.setTitle(BrowserInfo.currentWorkspace, for: .normal)
        gMenuButton.contentHorizontalAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: SizeConstants.Padding * 2)
        descipLabel.font = UIFont.systemFont(ofSize: SizeConstants.Padding)
        
        
    }
    

    
    override func sliderDidOpen() {
        titleLabel.text = BrowserInfo.currentWorkspace
        let workspace = (workspaceStorageManager.fetchObjects(fromDisk: false) as? [Workspace])?.filter{
            $0.title == BrowserInfo.currentWorkspace
        }

        descipLabel.text = String(describing: workspace![0].savedTabs?.allObjects.count)
    }

    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerStack = UIStackView()
        let optionBtnStack = ButtonBarStack()
        let titleBtnStack = ButtonBarStack()
        let backDrop = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        backDrop.contentView.addSubview(view: headerStack, attributes: [.left,.right,.top,.bottom])
        titleBtnStack.axis = .vertical
        headerStack.axis = .vertical
        
        
        titleBtnStack.addItems(items: [titleLabel,descipLabel])
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "background-image")
        
        imageView.contentMode = .scaleAspectFit
        let padding = SizeConstants.Padding * 2
        headerStack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        headerStack.isLayoutMarginsRelativeArrangement = true
        imageView.heightAnchor.constraint(equalToConstant: SizeConstants.Padding * 10).isActive = true
        headerStack.spacing = SizeConstants.Padding * 3
        headerStack.addArrangedSubview(imageView)
        headerStack.addArrangedSubview(optionBtnStack)
        imageView.addSubview(view: titleBtnStack, attributes: [.centerX,.centerY])
        optionBtnStack.addItems(items: [BlurButton(image: #imageLiteral(resourceName: "new-workspace")), BlurButton(image: #imageLiteral(resourceName: "image")) , BlurButton(image: #imageLiteral(resourceName: "delete"))])
        return backDrop
    }
    
    
}
