//
//  GProgressView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/20/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//


import UIKit


class GProgressView:UIStackView{
    private(set) var progressBar = UIProgressView()
    private(set) var progressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.addArrangedSubview(progressBar)
        self.addArrangedSubview(progressLabel)
        progressLabel.textColor = UIColor.System.Light
        progressLabel.textAlignment = .center
        self.spacing = 5
    }
    
    func progressUpdate(message : String, progress : Float){
        progressLabel.text = message
        progressBar.setProgress(progress, animated: false)
        
    }
    
    
    required convenience init(coder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
    
    
    
}
