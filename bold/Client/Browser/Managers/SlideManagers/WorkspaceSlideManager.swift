//
//  WorkspaceSlideManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 2/21/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


protocol ImagePickerDelegate{
    func imagePicker(_ imagePicker : UIImagePickerController, imageChosen : UIImage)
    func imagePicker(_ imagePicker : UIImagePickerController, imageNotChosen : UIImage)
}



class WorkspaceSlideManager:OptionSlideManager{
    private let titleLabel = GLabel()
    private let descipLabel =  GLabel()
    public var tabScrollManager:TabScrollManager?
    private let padding = SizeConstants.Padding * 2
    private var tagStorageManager = StorageManager<SavedTag>()
    private(set) var wsStorageManager:WorkspaceStorageManager
    private var wsPromptManager:WorkspacePromptManager!
    private var bgPromptManager:BackgroundPromptManager!
    private(set) var imageView = UIImageView()
    private var imChooseManager = ImageChooseManager()

    init(gMenuButton : GMenuButton, wsStorageManager : WorkspaceStorageManager) {
        self.wsStorageManager = wsStorageManager
        super.init(gMenuButton : gMenuButton)
        self.wsPromptManager = WorkspacePromptManager(wsSlideManager : self)
        self.bgPromptManager = BackgroundPromptManager(wsSlideManager : self)
        wsStorageManager.fetchObjects(fromDisk: true)
        tagStorageManager.fetchObjects(fromDisk: true)
        gMenuButton.alternateSelection = true
        imChooseManager.imagePickerDelegate = self
        gMenuButton.setTitle(BrowserInfo.currentWorkspace, for: .normal)
        gMenuButton.contentHorizontalAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: padding)
        descipLabel.font = UIFont.systemFont(ofSize: SizeConstants.Padding)
        
        
        wsStorageManager.updateBackgroundImage()
    }
    
    


    
    override func sliderDidOpen() {
        tabScrollManager?.dismissTimer.invalidate()
        titleLabel.text = BrowserInfo.currentWorkspace
        let allWorkspaces = (wsStorageManager.fetchObjects(fromDisk: false))
        var allTags = Dictionary<String,Int>()
        
        allWorkspaces.forEach{
            if let tagName = $0.title{
                if let existingTags = allTags[tagName]{
                    allTags[tagName] = existingTags + 1
                }else{
                    allTags[tagName] = 1
                }
            }
        }
        
        (tagStorageManager.fetchObjects(fromDisk: false)).forEach{
            if let tagName = $0.tagName{
                if let existingTags = allTags[tagName]{
                    allTags[tagName] = existingTags + 1
                }else{
                    allTags[tagName] = 1
                }
            }
        }
        
        let workspaces = (allWorkspaces.filter{
            $0.title == BrowserInfo.currentWorkspace
            })
            if workspaces.count > 0{
                let workspace = workspaces[0]
                var tagCount = 0
                if let tCount = allTags[BrowserInfo.currentWorkspace]{
                    tagCount = tCount
                }
                if let tabCount = workspace.savedTabs?.allObjects.count{
                    descipLabel.text = String(format: "%d Tabs • %d Tags", arguments: [tabCount,tagCount])
                }
                var gMenuOptions:[[GMenuOption]] = [[]]
                allTags.forEach{
                    let gMenuOption = GMenuOption(title: $0.key)
                    gMenuOptions[0].append(gMenuOption)
                }
                self.updateOptions(options: gMenuOptions)
                
            }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let gCell = tableView.cellForRow(at: indexPath) as? GTableViewCell{
            if let tagName = gCell.textLabel?.text{
                invokeTagSwitchEvent(tagName : tagName)
            }
        }
    }
    
    func invokeTagSwitchEvent(tagName : String){
        wsStorageManager.switchWorkspace(fromTag: tagName)
        gMenuButton?.setTitle(BrowserInfo.currentWorkspace, for: .normal)
        sliderDidOpen()
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
        if let imData = wsStorageManager.currentWorkspace.backgroundData{
            imageView.image = UIImage(data : imData)
        }
        
        imageView.contentMode = .scaleAspectFit
        headerStack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        headerStack.isLayoutMarginsRelativeArrangement = true
        imageView.heightAnchor.constraint(equalToConstant: SizeConstants.Padding * 10).isActive = true
        headerStack.spacing = SizeConstants.Padding * 3
        headerStack.addArrangedSubview(imageView)
        headerStack.addArrangedSubview(optionBtnStack)
        
        imageView.addSubview(view: titleBtnStack, attributes: [.centerX,.centerY])
        let addWSBtn = BlurButton(image: #imageLiteral(resourceName: "new-workspace"))
        addWSBtn.addTarget(wsPromptManager, action: #selector(wsPromptManager.addWorkspacePrompt), for: .touchDown)
        let imageChooseBtn = BlurButton(image: #imageLiteral(resourceName: "image"))
        imageChooseBtn.addTarget(imChooseManager, action: #selector(imChooseManager.setBackgroundImage), for: .touchDown)
        let removeWSBtn = BlurButton(image: #imageLiteral(resourceName: "delete"))
        removeWSBtn.addTarget(wsPromptManager, action: #selector(wsPromptManager.removeWorkSpacePrompt), for: .touchDown)
        optionBtnStack.addItems(items: [addWSBtn, imageChooseBtn , removeWSBtn])
        return backDrop
    }
    
}

extension WorkspaceSlideManager:ImagePickerDelegate{
    func imagePicker(_ imagePicker: UIImagePickerController, imageChosen: UIImage) {
        wsStorageManager.updateBackgroundImage(image: imageChosen)
        if let imData = wsStorageManager.currentWorkspace.backgroundData{
            imageView.image = UIImage(data : imData)
        }
    }
    
    func imagePicker(_ imagePicker: UIImagePickerController, imageNotChosen: UIImage) {
        self.bgPromptManager.imageCanceledPrompt()
    }
    

}
