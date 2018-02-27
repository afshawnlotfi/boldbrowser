//
//  PDFPageOption.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/17/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit



class PDFPagePageOption:NSObject,SliderOption,SliderOptionDelegate,PDFGenerationManagerDelegate{
   
    func pdfGenerationManager(_ pdfGenerationManager: PDFGenerationManager, didUpdatePDFProgress progress: Float) {
        progressView.progressLabel.text = SliderOptionStrings.PDFGenerationStatusGenerating + " : " + String(Int(progress*100)) + "%"
        progressView.progressBar.setProgress(progress, animated: true)

    }
    
    func pdfGenerationManager(_ pdfGenerationManager: PDFGenerationManager, didFinishGeneration data: Data, webView : TabWebView) {
        
        
        var storageDefaults = PDFStorageDefaults()
        
        if let url = webView.url, let title = webView.title{
            
            storageDefaults.url = url.absoluteString
            storageDefaults.title = title
            
        }
        storageDefaults.data = data
        writeToDisk(storageDefaults: storageDefaults)
        
        
        progressView.progressLabel.text = SliderOptionStrings.PDFGenerationStatusFinished
        progressView.progressBar.setProgress(1.0, animated: true)
        
        writeToDisk(storageDefaults: storageDefaults)
        
        
        DispatchQueue.main.asyncAfter(deadline:  DispatchTime.now()  + TimeConstants.Delay){
            self.deactivateOption()
        }
       
        
        
    }
    
    private var storageManager = StorageManager<PDF>()
    private var toastView = GToastView()
    private var pdfManager = PDFGenerationManager()
    public var sliderControllerDelegate:SliderManagerDelegate?
    private var progressView = GProgressView()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate

    override init() {
        super.init()
        toastView.addOptions(options: [progressView])
        progressView.progressLabel.text = SliderOptionStrings.PDFGenerationStatusStarting + " ..."
        toastView.setSpacing(spacing: 20)
        toastView.setImage(image: UIImage.tintImage(image: #imageLiteral(resourceName: "download")))
        pdfManager.pdfGenerationManagerDelegate = self
        toastView.setDismissSelector(selector: GSelector(target:  self.pdfManager, selector: #selector(self.pdfManager.stopGeneration)))

    }
    
    func sliderOption(didSelectCell cell: GTableViewCell, webView: TabWebView) {
            activateOption()
        
        
        
            toastView.showToast(view: appDelegate.browserViewController.view)
            
            let alert = UIAlertController(title: SliderOptionStrings.PDFGenerationTypeTitle, message: SliderOptionStrings.PDFGenerationTypeMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: String.OptionStrings.Cancel, style: .cancel, handler: { [] (_) in
                self.toastView.dismissFromScreen()
            }))

            alert.addAction(UIAlertAction(title: SliderOptionStrings.PDFFullScreen, style: .default, handler: { [] (_) in
                self.pdfManager.scanWebpage(webView: webView)
            }))


            alert.addAction(UIAlertAction(title: SliderOptionStrings.PDFPrintPreview, style: .default, handler: { [] (_) in
                self.pdfManager.createPrintPreview(webView: webView, pageSize: PageType.A4)

            }))


            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    
    
 
    
    func writeToDisk(storageDefaults : PDFStorageDefaults){
    
        let matchingIndecies = ((self.storageManager.fetchObjects(fromDisk: false)).filter{ $0.url == storageDefaults.url})

        
        if matchingIndecies.count == 0{
            self.storageManager.addObject(from: storageDefaults)
        }else{
            self.storageManager.updateObject(updatedValues: ["data" : storageDefaults.data], object: matchingIndecies[0])
            
        }
        
        print(storageManager.dataObjects)
        
    }
    
    
    func activateOption() {
        sliderControllerDelegate?.sliderWillClose()
    }
    

    func deactivateOption() {
        
        toastView.dismissFromScreen()
        
    }
    
    
}
