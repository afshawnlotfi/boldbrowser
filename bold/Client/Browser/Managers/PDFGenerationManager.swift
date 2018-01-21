//
//  PDFGenerationManager.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/17/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit
import WebKit


protocol PDFGenerationManagerDelegate{
    
    func pdfGenerationManager(_ pdfGenerationManager : PDFGenerationManager, didUpdatePDFProgress progress : Float)
    func pdfGenerationManager(_ pdfGenerationManager: PDFGenerationManager, didFinishGeneration data: Data, webView : TabWebView)

    
}


class PDFGenerationManager{
    
    var generationTimer = Timer()
    var webView:TabWebView?
    public var pdfGenerationManagerDelegate:PDFGenerationManagerDelegate?
    
    func scanWebpage(webView : TabWebView){
        var outputData = Data()
        self.webView = webView
        var images = [UIImage]()
        let pageHeight = webView.bounds.height
        webView.isUserInteractionEnabled = false
        let numberOfPages = ceil(webView.scrollView.contentSize.height/pageHeight)
        generationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            
            let remainingOffset =  webView.scrollView.contentSize.height - webView.scrollView.contentOffset.y
            
            if remainingOffset < pageHeight{
                if remainingOffset != 0 {
                    let image = webView.screenshot()
                    images.append(image)
                }
                
                self.generationTimer.invalidate()



                let image = self.stitchImages(images: images, isVertical: true)
                outputData = self.createPDF(fromImage: image)
                webView.isUserInteractionEnabled = true
                webView.scrollView.contentOffset.y = 0
                self.pdfGenerationManagerDelegate?.pdfGenerationManager(self, didFinishGeneration: outputData, webView: webView)


            }else{
                let image = webView.screenshot()
                images.append(image)
                self.pdfGenerationManagerDelegate?.pdfGenerationManager(self, didUpdatePDFProgress: Float(images.count)/Float(numberOfPages))

                webView.scrollView.contentOffset.y += pageHeight
            }
        }
    }

    
    
    
    
    
    func createPrintPreview(webView : TabWebView, pageSize : CGSize){
        var outputData = NSMutableData()
        self.webView = webView

        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        if let url = webView.url{
            printInfo.jobName = url.absoluteString

        }
        printInfo.duplex = UIPrintInfoDuplex.longEdge
        let formatter: UIViewPrintFormatter = webView.viewPrintFormatter()
        
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        let pageRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
        let inset = pageRect.insetBy(dx: 0, dy: 0)
        renderer.setValue(NSValue(cgRect: pageRect), forKey: "paperRect")
        renderer.setValue(NSValue(cgRect: inset), forKey: "printableRect")
        
        outputData = NSMutableData()
        UIGraphicsBeginPDFContextToData(outputData, CGRect.zero, nil)
        
        
        for pageNumber in 1...renderer.numberOfPages {

            self.pdfGenerationManagerDelegate?.pdfGenerationManager(self, didUpdatePDFProgress: Float(pageNumber)/Float(renderer.numberOfPages))

            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            renderer.drawPage(at: pageNumber - 1, in: bounds)
            
        }
        UIGraphicsEndPDFContext();
        self.pdfGenerationManagerDelegate?.pdfGenerationManager(self, didFinishGeneration: outputData as Data, webView: webView)

        
    }
    
    
    
    
    
    func createPDF(fromImage: UIImage) -> Data {
        //Raw Data
        let pdfData = NSMutableData()
        //Place Image in view
        let imageView = UIImageView(image: fromImage)
        let imageRect = CGRect(x: 0, y: 0, width: fromImage.size.width, height: fromImage.size.height)
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        imageView.layer.render(in: context!)
        UIGraphicsEndPDFContext()
        return pdfData as Data
    }
    
    
    func stitchImages(images: [UIImage], isVertical: Bool) -> UIImage {
        var stitchedImage = UIImage()
        
            var widthMax:CGFloat = 0
            var heightMax:CGFloat = 0
            var imageDimensions = CGSize(width: 0, height: 0)

            //Sizes Image
            images.forEach{
                switch isVertical{
                    
                    case true:
                        imageDimensions = CGSize(width: $0.size.width, height: imageDimensions.height + $0.size.height)
                    case false:
                        imageDimensions = CGSize(width: imageDimensions.width + $0.size.width , height: $0.size.height )
                }
                if $0.size.width > widthMax{
                    widthMax = $0.size.width
                }
                if $0.size.height > heightMax{
                    heightMax = $0.size.height
                }
            }
        
            UIGraphicsBeginImageContext(imageDimensions)
            
            //Scans through each one and stitches
            for (index,image) in images.enumerated(){
                var imageRect:CGRect
                switch isVertical{
                    case true:
                        imageRect = CGRect(x: 0, y: widthMax * CGFloat(index), width: widthMax, height: heightMax)
                    case false:
                        imageRect = CGRect(x: widthMax * CGFloat(index), y: 0, width: widthMax, height: heightMax)
                }
                image.draw(in: imageRect)
            }
            stitchedImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
            UIGraphicsEndImageContext()
        
        return stitchedImage
        
    }
    
    
    
    
    @objc func stopGeneration(){
        generationTimer.invalidate()
        self.webView?.isUserInteractionEnabled = true
        self.webView?.scrollView.contentOffset.y = 0
    }
    
    
    
    
    
    
    
}
