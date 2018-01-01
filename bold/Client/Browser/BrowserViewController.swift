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

extension BrowserViewController:TabManagerDelegate{
    
    
    func tabManager(_ tabManager: TabManager, didAddTab atIndex: IndexPath, tab: Tab) {
        tab.tabDelegate = self

    }
    
    func tabManager(_ tabManager: TabManager, didRemoveTab atIndex: IndexPath, tab: Tab) {
        
    }
    
    func tabManager(_ tabManager: TabManager, didSelectTab atIndex: IndexPath, tab: Tab) {
        
    }
    
    func tabManager(_ tabManager: TabManager, didUpdateTitle atIndex: IndexPath, title: String) {
        tabManager.tabs[atIndex.row].webView?.evaluateJavaScript("main()")

    }
    
    func tabManager(_ tabManager: TabManager, didUpdateFaviconURL atIndex: IndexPath, faviconURL: String) {
        
    }
    
   

}


extension BrowserViewController:TabDelegate{
    func tab(_ tab: Tab, didCreateWebview webView: TabWebView, atIndex : IndexPath) {
        let faviconManager = FaviconManager()
        let faviconPlugin = TabPluginScript(pluginName: "favicon", manager: faviconManager)

        self.tabManager.addObserver(tab: tab, observerKeys: [ObserverStrings.EstimatedProgressObserver,ObserverStrings.TitleObserver,ObserverStrings.FaviconObserver, ObserverStrings.URLObserver])
        
        
        self.tabManager.addTabPluginScripts(tab: tab, tabScripts: [faviconPlugin])

    }
    
    @objc func gooz(){
        
    }
    
}





