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
    private var tabManager = TabManager()
    private var tabCollectionView: TabCollectionView
    @IBOutlet private var tabStack: UIStackView!
    
    init() {
        self.tabCollectionView = TabCollectionView(tabManager: tabManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabStack.addArrangedSubview(self.tabCollectionView)

//        let s = StorageManager<SavedTab>()
//        s.addObject(from: SavedTabDefaults())
//        let objects = s.fetchObjects()
//        print((objects[0] as! SavedTab).title)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension BrowserViewController:TabDelegate{
    func tab(_ tab: Tab, didCreateWebView webView: WKWebView) {

    }

    func tab(_ tab: Tab, willDeleteWebView webView: WKWebView) {

    }


}

