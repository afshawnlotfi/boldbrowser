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
    @objc public var faviconURL:String = ""
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration:  configuration)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.allowsBackForwardNavigationGestures = true
        self.allowsLinkPreview = false
        progressBar.isHidden = true
        progressConstraints = self.addSubview(view: progressBar, attributes: [.top,.left,.right])
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


