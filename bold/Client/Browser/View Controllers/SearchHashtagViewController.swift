//
//  SearchHashtagViewController.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/20/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class SearchHashtagViewController: UIViewController {

    
    private var boldService = BoldWebServiceManager()
    
    @IBOutlet private weak var contentStack: UIStackView!
    private var hashTagCollectionView = SelectionCollectionView()
    private var searchHashTagTableView = GTableView()
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet private weak var searchIconBtn: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    private var hashtagSelectionManager = SelectionManager<String>()
    
    private var collectionHeight:NSLayoutConstraint!
    
    override func viewDidLoad() {

        super.viewDidLoad()
    
        searchIconBtn.tintColor = UIColor.System.Light
        closeBtn.tintColor = UIColor.System.Light
        closeBtn.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(suggestTags(_:)), for: .editingChanged)
        searchTextField.textColor = UIColor.System.Light
        searchTextField.attributedPlaceholder = NSAttributedString(string: BrowserStrings.SearchPlaceholder,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.System.FadedWhite])
        
        hashTagCollectionView.selectionManager.selectionManagerDelegate = self
        hashTagCollectionView.selectionManager.items = [[]]
        searchHashTagTableView.dataSource = hashtagDataSource
        searchHashTagTableView.separatorColor = UIColor.System.FadedWhite
        searchHashTagTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        hashtagSelectionManager.items = [[]]
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
    
    
    @objc func suggestTags(_ textField : UITextField){
        let tags = boldService.searchHashtags(fromKeyword: textField.text!, atWebsite: "https://www.google.com")
        hashtagSelectionManager.items = [tags]
        searchHashTagTableView.reloadData()
    }
    
    func presentView(){
        
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
        searchTextField.becomeFirstResponder()
        
    }
    
    private lazy var hashtagDataSource: GTVDataSource<String> = {
        let checkFormatter = CheckCellFormatter(selectionManager: hashTagCollectionView.selectionManager)
        return  GTVDataSource<String>(selectionManager: hashtagSelectionManager, cellFormatter: checkFormatter)
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
        self.hashTagCollectionView.reloadData()
        for (index,cell) in hashTagCollectionView.visibleCells.enumerated(){
            cell.tag = index
        }
    }

    func selectionManager(didRemoveObject: IndexPath) {
        self.searchHashTagTableView.reloadData()
        self.hashTagCollectionView.deleteItems(at: [didRemoveObject])
        for (index,cell) in hashTagCollectionView.visibleCells.enumerated(){
            cell.tag = index
        }
    }
}



