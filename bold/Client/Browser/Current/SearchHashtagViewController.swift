//
//  SearchHashtagViewController.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/20/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class SearchHashtagViewController: UIViewController {

    @IBOutlet private weak var contentStack: UIStackView!
    private var hashTagCollectionView = SelectionCollectionView()
    private var searchHashTagTableView = GTableView()
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet private weak var searchIconBtn: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    
    private var collectionHeight:NSLayoutConstraint!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        
        searchIconBtn.tintColor = UIColor.System.Light
        closeBtn.tintColor = UIColor.System.Light
        closeBtn.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        searchTextField.textColor = UIColor.System.Light
        searchTextField.becomeFirstResponder()
        searchTextField.attributedPlaceholder = NSAttributedString(string: BrowserStrings.SearchPlaceholder,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.System.FadedWhite])
        
        hashTagCollectionView.selectionManager.selectionManagerDelegate = self
        hashTagCollectionView.selectionManager.items = [["yolowag", "hello", "world","yolowag123455","yolowag212"]]
        searchHashTagTableView.dataSource = hashtagDataSource
        searchHashTagTableView.separatorColor = UIColor.System.FadedWhite
        searchHashTagTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        hashTagCollectionView.horizontalScroll(true)
        collectionHeight = hashTagCollectionView.heightAnchor.constraint(equalToConstant: 45)
        collectionHeight.isActive = true
        contentStack.spacing = 10
        hashTagCollectionView.showsHorizontalScrollIndicator = false
        self.contentStack.isLayoutMarginsRelativeArrangement = true
        self.contentStack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.contentStack.addArrangedSubview(hashTagCollectionView)
        self.contentStack.addArrangedSubview(searchHashTagTableView)
    }
    
    private lazy var hashtagDataSource: GTVDataSource<String> = {
        let checkFormatter = CheckCellFormatter(selectionManager: hashTagCollectionView.selectionManager)
        return  GTVDataSource<String>(selectionManager: hashTagCollectionView.selectionManager, cellFormatter: checkFormatter)
    }()

    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    @objc private func closeViewController(){
        self.dismiss(animated: true, completion: nil)
    
    }
    

}


extension SearchHashtagViewController:SelectionDelegate{
    func selectionManager(didAddObject: IndexPath, item: Any) {
        self.hashTagCollectionView.reloadItems(at: [didAddObject])
    }

    func selectionManager(didRemoveObject: IndexPath) {
        self.searchHashTagTableView.deleteRows(at: [didRemoveObject], with: .fade)
    }

}



