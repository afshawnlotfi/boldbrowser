//
//  BrowserViewController.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/18/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {

    @IBOutlet weak var optionStack: UIStackView!
    @IBOutlet weak var topMenu: UIVisualEffectView!
    @IBOutlet weak var topMenuHeightLC: NSLayoutConstraint!
    @IBOutlet private var backgroundImageView: UIImageView!
    private var tabManager:TabManager!
    @IBOutlet weak var workspaceBtn: GMenuButton!
    private var tabCollectionView: TabCollectionView!
    @IBOutlet private var tabStack: UIStackView!
    @IBOutlet private var addTabBtn: UIButton!
    private var tabScrollManager = TabScrollManager()
    @IBOutlet private weak var showTabsBtn: UIButton!
    private var workspaceSlideManager:WorkspaceSlideManager!
    private var workspaceStorageManager:WorkspaceStorageManager!
    private var optionBarStack = ButtonBarStack()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workspaceStorageManager = WorkspaceStorageManager()
        self.tabManager = TabManager(wsStorageManager: workspaceStorageManager)
        self.tabCollectionView = TabCollectionView(tabManager: tabManager)
        self.tabStack.addArrangedSubview(self.tabCollectionView)
        self.tabManager.restoreTabs()
        self.addTabBtn.addTarget(self, action: #selector(addTabToDisk), for: .touchDown)
        self.showTabsBtn.addTarget(self, action: #selector(showAllTabs), for: .touchDown)
        self.tabScrollManager.tabScrollDelegate = self
        self.tabManager.tabScrollManager = tabScrollManager
        self.tabCollectionView.tabFlowLayout.tabCollectionViewDelegate = self
        topMenu.isHidden = true
        optionStack.heightAnchor.constraint(equalToConstant: topMenuHeightLC.constant).isActive = true
        UIApplication.shared.isStatusBarHidden = true
        
        self.topMenu.contentView.addSubview(view: optionBarStack, attributes: [.right,.left,.bottom])
        optionBarStack.isHidden = true
        optionBarStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let options = ["Tags","Tags"]
        
        for (index,option) in options.enumerated(){
            let optionBtn = GMenuButton()
            optionBtn.backgroundColor = UIColor(white: 0.8, alpha: 0.1)
            optionBtn.setTitle(option, for: .normal)
            optionBtn.tag = index
            optionBarStack.addItems(items: [optionBtn])
        }
        
        
        
        self.workspaceSlideManager = WorkspaceSlideManager(gMenuButton: workspaceBtn, wsStorageManager: workspaceStorageManager)
        self.workspaceSlideManager.tabScrollManager = tabScrollManager
        var buttonDefaults = OptionButtonDefaults(view: tabStack)
        buttonDefaults.isRightSide = false
        buttonDefaults.unselectedImage = #imageLiteral(resourceName: "arrow-right")
        buttonDefaults.selectedImage = #imageLiteral(resourceName: "arrow-left")
        workspaceBtn.configureButton(buttonDefaults: buttonDefaults)
        workspaceBtn.gMenuButtonDelegate = workspaceSlideManager
        let sliderOptions = WorkspaceSliderOptions()
        workspaceSlideManager.updateOptions(options: sliderOptions.menuOptions)
    }
    @objc func addTabToDisk(){
        self.tabManager.addTab(atIndex: nil, configuration: nil, restoreFrom: nil)
    }
    
    func changeBackgroundImage(image : UIImage){
        self.backgroundImageView.image = image
    }
    
    
    private func getSelectedIndexPath(from tabCollectionView : TabCollectionView) -> IndexPath{
        
        let selectedCells = self.tabCollectionView.visibleCells.filter{$0.isSelected == true}
        if selectedCells.count > 0{
            if let cell = (selectedCells[0] as? GContainerCVCell){
                if let indexPath = cell.indexPath{
                    return indexPath
                }else if let indexPath = tabCollectionView.indexPath(for: cell){
                    return indexPath

                }else{
                    return IndexPath(row: 0, section: 0)
                }
            }else{
                return IndexPath(row: 0, section: 0)
            }
        }else{
            return IndexPath(row: 0, section: 0)
        }
    }
    
    
    @objc func showAllTabs(){
        let indexPath = getSelectedIndexPath(from: tabCollectionView)
        if tabCollectionView.tabFlowLayout.isMinimized == false{
            tabCollectionView(self.tabCollectionView, didMinmizeCells : indexPath)
            tabCollectionView.reloadData()
        }else{
            tabCollectionView(self.tabCollectionView, didMaximizeCells : indexPath)
        }
    }
    
        
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tabCollectionView.collectionViewLayout.invalidateLayout()
        let indexPath = self.getSelectedIndexPath(from: self.tabCollectionView)

        
        DispatchQueue.main.asyncAfter(deadline:  DispatchTime.now()  + TimeConstants.Timeout){
            self.tabCollectionView.scrollToItem(at:  indexPath, at: .right, animated: false)
        }
    }
    
}
    

extension BrowserViewController:TabCollectionViewDelegate{
    
    func tabCollectionView(_ tabCollectionView: TabCollectionView, didMaximizeCells atIndexPath: IndexPath) {
            self.topMenuHeightLC.constant -= 50
            optionBarStack.isHidden = true
            tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isMinimized: false)
            tabCollectionView.horizontalScroll(true)
            tabCollectionView.isPagingEnabled = true
            invokeTopMenu(showTopMenu: false)
            invokeTitleMenu(showTitleMenu: true)
            tabScrollManager.dismissTimer.invalidate()
            tabCollectionView.scrollToItem(at:  atIndexPath, at: [.centeredHorizontally,.centeredVertically], animated: false)
            tabCollectionView.reloadData()
            focusCells()
    }
    
    func tabCollectionView(_ tabCollectionView: TabCollectionView, didMinmizeCells atIndexPath: IndexPath) {
        self.topMenuHeightLC.constant += 50
        optionBarStack.isHidden = false
        if tabCollectionView.tabFlowLayout.isMinimized == false{
            tabManager.updateTabScreenshot(atIndex: atIndexPath.row, withDelay: false)
            tabCollectionView.horizontalScroll(false)
            tabCollectionView.isPagingEnabled = false
            tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isMinimized: true)
            invokeTopMenu(showTopMenu: true)
            tabScrollManager.dismissTimer.invalidate()
            tabCollectionView.scrollToItem(at:  atIndexPath, at: [.centeredHorizontally,.centeredVertically], animated: false)

        }
    }
    
    
    
}



extension BrowserViewController:TabScrollManagerDelegate{
    
    func invokeTopMenu(showTopMenu : Bool){
        let selectedCells = self.tabCollectionView.visibleCells

        if self.topMenu.isHidden == showTopMenu{
            UIApplication.shared.isStatusBarHidden = !showTopMenu
            self.tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isMinimized: self.tabCollectionView.tabFlowLayout.isMinimized, isTopMenuVisible: showTopMenu)
            self.tabCollectionView.collectionViewLayout.invalidateLayout()
            if self.tabCollectionView.tabFlowLayout.isMinimized == false{
                for cell in selectedCells{
                    if let tabCell = cell as? GContainerCVCell{
                        tabCell.maximizeCell(withCurves: showTopMenu)
                    }

                }
            }
            UIView.animate(withDuration: TimeConstants.Animation, animations: {
                self.topMenu.isHidden = !showTopMenu
            })
            
        }
    }
    
    
    
    
    
    
    func invokeTitleMenu(showTitleMenu : Bool){
        let selectedCells = self.tabCollectionView.visibleCells.filter{$0.isSelected == true}

        if tabCollectionView.tabFlowLayout.isTitleMenuVisible == !showTitleMenu{
            self.tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isTitleMenuVisible: showTitleMenu)
            self.tabCollectionView.collectionViewLayout.invalidateLayout()
            for cell in selectedCells{
                if let tabCell = cell as? GContainerCVCell{
                    UIView.animate(withDuration: TimeConstants.Animation, animations: {
                        tabCell.titleMenu.isHidden = !showTitleMenu
                    })
                }
            }
        }
    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didShowTopMenu gesture: UIPanGestureRecognizer) {
        unFocusCells()
        invokeTopMenu(showTopMenu: true)

    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didHideTopMenu gesture: UIPanGestureRecognizer) {
        focusCells()
        invokeTopMenu(showTopMenu: false)

    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didShowTitleMenu gesture: UIPanGestureRecognizer) {
        invokeTitleMenu(showTitleMenu: true)

    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didHideTitleMenu gesture: UIPanGestureRecognizer) {
        invokeTitleMenu(showTitleMenu: false)

    }
    
    func focusCells(){
        let selectedCells = self.tabCollectionView.visibleCells.filter{$0.isSelected == true}
        tabCollectionView.optionButtonManager.isTabFocused = true
        for cell in selectedCells{
            if let tabCell = cell as? GContainerCVCell{
                UIView.animate(withDuration: TimeConstants.Animation, animations: {
                    self.tabCollectionView.optionButtonManager.updateFocusOptions(gCell: tabCell, tab: self.tabManager.tabs[tabCell.tag])
                    
                })
            }
        }
    }
    
    func unFocusCells(){
        let selectedCells = self.tabCollectionView.visibleCells.filter{$0.isSelected == true}
        tabCollectionView.optionButtonManager.isTabFocused = false
        for cell in selectedCells{
            if let tabCell = cell as? GContainerCVCell{
                UIView.animate(withDuration: TimeConstants.Animation, animations: {
                    self.tabCollectionView.optionButtonManager.updateUnFocusOptions(gCell: tabCell)
                    
                })
            }
        }
    }
    

}


