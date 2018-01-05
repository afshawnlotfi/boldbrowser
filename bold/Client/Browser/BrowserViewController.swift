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
    @IBOutlet weak var topMenu: UIVisualEffectView!
    @IBOutlet private var backgroundImageView: UIImageView!
    private var tabManager:TabManager!
    private var tabCollectionView: TabCollectionView!
    @IBOutlet private var tabStack: UIStackView!
    @IBOutlet private var addTabBtn: UIButton!
    private var tabScrollManager = TabScrollManager()
    @IBOutlet private weak var showTabsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabManager = TabManager()
        self.tabCollectionView = TabCollectionView(tabManager: tabManager)
        self.tabStack.addArrangedSubview(self.tabCollectionView)
        self.tabManager.restoreTabs()
        self.addTabBtn.addTarget(self, action: #selector(addTabToDisk), for: .touchDown)
        self.showTabsBtn.addTarget(self, action: #selector(showAllTabs), for: .touchDown)
        self.tabScrollManager.tabScrollDelegate = self
        self.tabManager.tabScrollManager = tabScrollManager
        self.tabCollectionView.tabCollectionDelegate = self
        topMenu.isHidden = true
        UIApplication.shared.isStatusBarHidden = true

    }
    @objc func addTabToDisk(){
        
        self.tabManager.addTab(atIndex: nil, configuration: nil, restoreFrom: nil)
        
    }
    
    @objc func showAllTabs(){
        if tabCollectionView.tabFlowLayout.isMinimized == false{
            tabCollection(self.tabCollectionView, didMinmizeCells : IndexPath(row: 0, section: 0))
            tabCollectionView.reloadData()
        }else{
            tabCollection(self.tabCollectionView, didMaximizeCells : IndexPath(row: 0, section: 0))
            tabCollectionView.reloadData()
        }


    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }

}


extension BrowserViewController:TabCollectionDelegate{
    func tabCollection(_ tabCollection: TabCollectionView, didMinmizeCells atIndexPath: IndexPath) {
        tabCollection.horizontalScroll(false)
        tabCollection.isPagingEnabled = false
        self.tabScrollManager(tabScrollManager, didShowTopMenu: UIPanGestureRecognizer())
        tabCollection.tabFlowLayout.updateCollectionViewInsets(isMinimized: true)
        tabScrollManager.dismissTimer.invalidate()
    }
    
    func tabCollection(_ tabCollection: TabCollectionView, didMaximizeCells atIndexPath: IndexPath) {
        tabCollection.horizontalScroll(true)
        tabCollection.isPagingEnabled = true
        tabCollection.tabFlowLayout.updateCollectionViewInsets(isMinimized: false)
        tabScrollManager.dismissTimer.invalidate()
    }

}



extension BrowserViewController:TabScrollManagerDelegate{
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didShowTopMenu gesture: UIPanGestureRecognizer) {

        if self.topMenu.isHidden == true{
            UIApplication.shared.isStatusBarHidden = false
            self.tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isMinimized: false, isTopMenuVisible: true)
            self.tabCollectionView.collectionViewLayout.invalidateLayout()
            UIView.animate(withDuration: 0.2, animations: {
                self.topMenu.isHidden = false
                self.topMenu.alpha = 1
            })
            
        }

    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didHideTopMenu gesture: UIPanGestureRecognizer) {

//        print("didHideTopMenu")

        if self.topMenu.isHidden == false{
            UIApplication.shared.isStatusBarHidden = true
            self.tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isMinimized: false, isTopMenuVisible: false)
            self.tabCollectionView.collectionViewLayout.invalidateLayout()

            UIView.animate(withDuration: 0.2, animations: {
                self.topMenu.isHidden = true
                self.topMenu.alpha = 0
            })

        }
    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didShowTitleMenu gesture: UIPanGestureRecognizer) {
        print("didShowTitleMenu")
        if tabCollectionView.tabFlowLayout.isTitleMenuVisible == false{
            self.tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isTitleMenuVisible: true)
            self.tabCollectionView.collectionViewLayout.invalidateLayout()
        }

    }
    
    func tabScrollManager(_ tabScrollManager: TabScrollManager, didHideTitleMenu gesture: UIPanGestureRecognizer) {
        print("didHideTitleMenu")
        if tabCollectionView.tabFlowLayout.isTitleMenuVisible == true{
            self.tabCollectionView.tabFlowLayout.updateCollectionViewInsets(isTitleMenuVisible: false)
            self.tabCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
    

}


