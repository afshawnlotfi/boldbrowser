//
//  DownloadPageOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/14/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class DownloadPageOption:NSObject,SliderOption,SliderOptionDelegate,DownloadManagerDelegate{
    
    
    
    func downloadManager(_ downloadManager: DownloadManager, didTakeSnapshot HTMLString: String) {

        activityWheel.stopAnimating()

        cell?.accessoryView = checkView
    }
    
    
    private var toastView = GToastView()
    private var webView:TabWebView?
    private var cell:GTableViewCell?
    private var activityWheel = UIActivityIndicatorView()
    private var checkView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

    override init() {
        super.init()
        activityWheel.hidesWhenStopped = true
        checkView.image = UIImage.tintImage(image: #imageLiteral(resourceName: "selected"))
        checkView.tintColor = UIColor.System.Light

    }
    
    func sliderOption(didSelectCell cell: GTableViewCell, webView: TabWebView) {
        self.webView = webView
        activateOption()
        self.cell = cell


        cell.accessoryView = activityWheel
        activityWheel.startAnimating()
        webView.evaluateJavaScript("downloadPage()")

    }
    
   
    
    func activateOption() {
     
    }
    
    @objc func deactivateOption() {
        
    }
 
    
}
