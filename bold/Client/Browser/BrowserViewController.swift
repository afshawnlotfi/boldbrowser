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
    @IBOutlet private var backgroundImageView: UIImageView!
    private var tabManager:TabManager!
    private var tabCollectionView: TabCollectionView!
    @IBOutlet private var tabStack: UIStackView!
    @IBOutlet var addTabBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabManager = TabManager()
        self.tabCollectionView = TabCollectionView(tabManager: tabManager)
        self.tabStack.addArrangedSubview(self.tabCollectionView)
        self.tabManager.restoreTabs()
        self.addTabBtn.addTarget(self, action: #selector(addTabToDisk), for: .touchDown)
    }
    @objc func addTabToDisk(){
        
        self.tabManager.addTab(atIndex: nil, configuration: nil, restoreFrom: nil)
        
    }

}


