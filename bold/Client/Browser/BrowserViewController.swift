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
        self.tabManager.tabManagerDelegates.append(self)
        self.tabManager.restoreTabs()
        self.addTabBtn.addTarget(self, action: #selector(addTabToDisk), for: .touchDown)

    }
    
    @objc func addTabToDisk(){
        
        self.tabManager.addTab(atIndex: nil, configuration: nil, restoreFrom: nil)
        
    }
   


}

extension BrowserViewController:TabDelegate, TabManagerDelegate{
    func tabManager(_ tabManager: TabManager, addTab at: IndexPath) {
        tabManager.tabs[at.row - 1].tabDelegate = self
    }
    
    func tabManager(_ tabManager: TabManager, removeTab at: IndexPath) {
        
    }
    
    func tabManager(_ tabManager: TabManager, selectedTab at: IndexPath) {
        
    }
    
    func tab(_ tab: Tab, didCreateWebView webView: WKWebView) {
        webView.addObserver(self, forKeyPath: BrowserStrings.TitleObserver, options: .new, context: nil)
    }

    func tab(_ tab: Tab, willDeleteWebView webView: WKWebView) {

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let webview = object as! WKWebView
        if let key = keyPath{
            switch key {
            case BrowserStrings.EstimatedProgressObserver:
                break
            case BrowserStrings.TitleObserver:
                break
            case BrowserStrings.URLObserver:
                break
            default:
                break
            }
        }
        
        
    }
    
 

}



