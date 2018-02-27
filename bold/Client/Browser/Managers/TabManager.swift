//
//  TabManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/21/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import Foundation
import WebKit

protocol TabManagerDelegate{
    
    func tabManager(_ tabManager : TabManager, didAddTab tab: Tab , atIndex : Int)
    func tabManager(_ tabManager : TabManager, didRemoveTab tab: Tab, atIndex : Int)
    func tabManager(_ tabManager : TabManager, didSelectTab tab: Tab, atIndex : Int)
    
}






class TabManager:NSObject{
    
    var tabs:[Tab] = []
    private(set) var tabScriptManager = TabScriptManager()
    private var routerManager = RouterManager()
    var tabScrollManager:TabScrollManager?
    private let storageManager:SavedTabStorageManager

    var tabManagerDelegates = [TabManagerDelegate]()
    
    init(wsStorageManager : WorkspaceStorageManager) {
        self.storageManager = SavedTabStorageManager(wsStorageManager: wsStorageManager)
        super.init()
        
        if BrowserInfo.currentWorkspace == String.empty{
            var workspaceKeyDefaults = WorkspaceKeyDefaults()
            workspaceKeyDefaults.value = "general"
            KeyStorageManager.setValue(from: workspaceKeyDefaults)
        }
        
        wsStorageManager.fetchObjects(fromDisk: true)
        
    }
    
    
    /// Adds tab at specified index with cofniguratio≈n
    ///
    /// - Parameters:
    ///   - atIndex: index to put tab
    ///   - configuration: configuration of webview
    ///   - restoreFrom: saved tab to restore new tab from
    func addTab(atIndex : Int? = nil, configuration : WKWebViewConfiguration? = nil, restoreFrom: SavedTab? = nil){
        var savedTab:SavedTab
        let configuration: WKWebViewConfiguration = configuration ?? WKWebViewConfiguration()
        let tab = Tab(configuration: configuration)
        
        if restoreFrom == nil{
            let savedTabDefaults = SavedTabDefaults(startIndex: tabs.count)
            savedTab = storageManager.addObject(from: savedTabDefaults, tagName: BrowserInfo.currentWorkspace)
        }else{
            savedTab = restoreFrom!
        }
        
        configureTab(tab: tab, savedTab: savedTab)

        if atIndex == nil{
            let tabIndex = tabs.count
            tabs.append(tab)
            tabManagerDelegates.forEach{$0.tabManager(self, didAddTab: tab, atIndex : tabIndex); $0.tabManager(self, didSelectTab: tab, atIndex : tabIndex)}
        }
        

    }
    
    /// Updates tab position in storage and in "tabs"
    ///
    /// - Parameters:
    ///   - current: current index
    ///   - final: final index
    func moveTab(current : Int , final : Int){
        //If tab webview is loaded update its observer index stored in tag used to index it in "observeValue"

        let currentTab = tabs.remove(at: current)
        tabs.insert(currentTab, at: final)
        for (index,tab) in tabs.enumerated(){
            tab.webView?.tag = index
        }
        self.storageManager.updatePosition(current: current, final: final)
        
    }
    

    
    /// Configure Tab
    ///
    /// - Parameters:
    ///   - tab: Tab to configure
    ///   - savedTab: Saved Tab to restore from
    func configureTab(tab : Tab, savedTab : SavedTab){
        tab.lastTitle = savedTab.title
        tab.faviconURL = savedTab.faviconURL
        if let screenshotData = savedTab.screenshotData as Data?{
            tab.screenshotImage = UIImage(data :screenshotData)
        }
       
        tab.tabSession = TabSession(data: savedTab.sessionData! as Data)
    
    }

    /// Adds KVO observers to tabs
    ///
    /// - Parameters:
    ///   - tab: Tabs you want to add observers
    ///   - observerKeys: Observer Keys
    func addObserver(tab : Tab, observerKeys : [String]){
        observerKeys.forEach{
            tab.webView?.addObserver(self, forKeyPath: $0, options: .new, context: nil)
        }
    }
    
    
    /// Adds scripts to tabs
    ///
    /// - Parameters:
    ///   - tab: Tabs you want to add scripts
    ///   - tabScripts: Scripts you want to inject
    func addTabPluginScripts(tab : Tab, tabScripts : [TabPluginScript]){
        tabScripts.forEach{
            tabScriptManager.addTabScript(tabScript: $0, atTab: tab)
        }
    }
    
    
    /// Takes screenshots of tab's current webview when loaded
    ///
    /// - Parameters:
    ///   - tab: tab to update screenshot
    ///   - atIndex: index of tab
    func updateTabScreenshot(atIndex : Int, withDelay : Bool  = true){
        
        func invokeScreenshot(){
            let tab = self.tabs[atIndex]
            if let screenshot = tab.webView?.screenshot(){
                print(screenshot.size.height)
                let snapshot = UIImage.cropImage(image: screenshot, size: CGSize(width: screenshot.size.width, height: screenshot.size.width - SizeConstants.TabTitleHeight))
                if let data = UIImagePNGRepresentation(snapshot){
                    tab.screenshotImage = snapshot
                    self.storageManager.updateObject(updatedValues: ["screenshotData":data], object: storageManager.fetchObjects(fromDisk: false, tagName: BrowserInfo.currentWorkspace)[atIndex])
                }
            }
        }
        
        if withDelay{
            //Takes screenshot with small delay to allow page to fully load
            DispatchQueue.main.asyncAfter(deadline:  DispatchTime.now()  + TimeConstants.ScreenShot){
                invokeScreenshot()
            }
        }else{
            invokeScreenshot()
        }
       

    }
    
    
    func configureWebview(tab : Tab, plugins : [TabPluginScript]){
        


        self.addObserver(tab: tab, observerKeys: [KVOConstants.estimatedProgress,KVOConstants.title,KVOConstants.faviconURL, KVOConstants.URL, KVOConstants.loading])
        
        
        self.addTabPluginScripts(tab: tab, tabScripts: plugins)
        tab.restoreWebview()
        tab.webView?.scrollView.panGestureRecognizer.addTarget(tabScrollManager!, action: #selector(tabScrollManager?.tabScrollUpdated(_:) ))
        //Accounts for extra tab length for showing and hiding title menu
        tab.webView?.scrollView.contentInset.bottom = SizeConstants.TabTitleHeight
    }
    
    
    /// Restores All Tabs from Saved Tabs
    func restoreTabs(){
        var savedTabs = storageManager.fetchObjects(fromDisk: true, tagName: BrowserInfo.currentWorkspace)

        if savedTabs.count == 0{
            self.addTab(atIndex: nil, configuration: nil, restoreFrom: nil)
            //Updates from Cached Saved Tabs
            savedTabs = storageManager.fetchObjects(fromDisk: false, tagName: BrowserInfo.currentWorkspace)

        }else{
            for savedTab in savedTabs{
                self.addTab(atIndex: nil, configuration: nil, restoreFrom: savedTab)
            }
        }
    }
    
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let webView = object as? TabWebView{
            let index = webView.tag
            let tab = tabs[index]
            let savedTab = (storageManager.fetchObjects(fromDisk: false, tagName: BrowserInfo.currentWorkspace))[index]
            let newValue = change?[NSKeyValueChangeKey(rawValue: "new")]
            if let key = keyPath{
                switch key {
                case KVOConstants.estimatedProgress:
                    //Updates webView progress bar
                    webView.progressBarUpdated()
                    tab.tabDelegate?.tab(tab, didUpdateProgress: webView, atIndex: index)
                case KVOConstants.title:
                    if let title = newValue as? String{
                        storageManager.updateObject(updatedValues: [KVOConstants.title:title], object: savedTab)
                        tab.lastTitle = title
                        tab.tabDelegate?.tab(tab, didUpdateTitle: title, atIndex: index)
                    }
                case KVOConstants.URL:
                    if let url = newValue as? String{
                        tab.lastURL = URL(string: url)
                    }
                case KVOConstants.faviconURL:
                    if let faviconURL = newValue as? String{
                        storageManager.updateObject(updatedValues: [KVOConstants.faviconURL:faviconURL], object: savedTab)
                        
                        //Updates Tab Favicon
                        tab.tabDelegate?.tab(tab, didUpdateFaviconURL: faviconURL, atIndex: index)

                        
                    }
                case KVOConstants.loading:
                    if let isLoading = newValue as? Bool{
                        if isLoading == false{
                            if webView.offlineLoaded == false{
                                tab.tabSession?.updateSession(tab: tab)
                                storageManager.updateObject(updatedValues: ["sessionData" : tab.tabSession?.data ?? TabSession.defaultData], object: savedTab)
                                tab.webView?.evaluateJavaScript("getFavicons()")
                            }
                            self.updateTabScreenshot(atIndex: index)
                            tab.tabDelegate?.tab(tab, didFinishLoading: index)
                        }else{
                            routerManager.route(webView: webView)
                        }
                    }
                default:
                    break
                }
            }
        }
        
    }
}
