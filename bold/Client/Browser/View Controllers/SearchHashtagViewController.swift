//
//  SearchHashtagViewController.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/20/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class SearchHashtagViewController: UIViewController {

    @IBOutlet private weak var selectedHashTagCollectionView: SelectionCollectionView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet private weak var searchIconBtn: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchIconBtn.tintColor = UIColor.System.Light
        closeBtn.tintColor = UIColor.System.Light
        closeBtn.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        searchTextField.textColor = UIColor.System.Light
        searchTextField.becomeFirstResponder()
        searchTextField.attributedPlaceholder = NSAttributedString(string: BrowserStrings.SearchPlaceholder,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.System.FadedWhite])

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    @objc private func closeViewController(){
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
