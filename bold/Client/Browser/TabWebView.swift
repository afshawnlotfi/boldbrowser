//
//  TabWebView.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit
import WebKit





class TabWebView:WKWebView{
    
    private var progressBar = UIProgressView()
    private var progressConstraints:[NSLayoutConstraint] = []
    private var storageManager = StorageManager<DownloadedWebsite>()
    public var offlineLoaded = false
    private(set) var observerKeys:[String:NSKeyValueObservingOptions] = [:]
    @objc public var faviconURL:String = ""
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration:  configuration)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.allowsBackForwardNavigationGestures = true
        self.allowsLinkPreview = false
        self.scrollView.layer.masksToBounds = false

        progressBar.isHidden = true
        progressConstraints = self.addSubview(view: progressBar, attributes: [.top,.left,.right])
    }
    
    func addWebViewObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        observerKeys[keyPath] = options
        self.addObserver(observer, forKeyPath: keyPath, options: options, context: context)
    }
    func removeWebViewObserver(_ observer: NSObject, forKeyPath keyPath: String, context: UnsafeMutableRawPointer?) {
        observerKeys.removeValue(forKey: keyPath)
        self.removeObserver(observer, forKeyPath: keyPath, context: context)
    }
    func removeAllWebViewObservers(_ observer: NSObject) {
        for key in observerKeys.keys{
            self.removeObserver(observer, forKeyPath: key)
        }
        self.observerKeys.removeAll()
    }
    
    
    func progressBarUpdated(){
        let updatedProgress:Float = Float(self.estimatedProgress)
        if updatedProgress > 0 && updatedProgress < 1{
            progressBar.isHidden = false
        }else{
            progressBar.isHidden = true
        }
        self.progressBar.progress = 0.0
        self.progressBar.setProgress(updatedProgress, animated: true)
    }
    
 
   
    required init?(coder: NSCoder) {
        self.init()
    }
    
    
    
}


