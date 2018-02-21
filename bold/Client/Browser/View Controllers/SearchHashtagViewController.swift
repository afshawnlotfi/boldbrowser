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
    private var currentURL = String.empty
    @IBOutlet private weak var contentStack: UIStackView!
    private var hashTagCollectionView = SelectionCollectionView()
    private var searchHashTagTableView = GTableView()
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet private weak var searchIconBtn: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    private var hashtagSelectionManager = SelectionManager<String>()
    private var storageManager = StorageManager<Tag>()
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
        searchHashTagTableView.dataSource = hashtagDataSource
        searchHashTagTableView.separatorColor = UIColor.System.FadedWhite
        searchHashTagTableView.separatorInset = UIEdgeInsets(top: 0, left: SizeConstants.Padding, bottom: 0, right: SizeConstants.Padding)
        hashtagSelectionManager.items = [[]]
        hashTagCollectionView.horizontalScroll(true)
        collectionHeight = hashTagCollectionView.heightAnchor.constraint(equalToConstant: 45)
        collectionHeight.isActive = true
        contentStack.spacing = SizeConstants.Padding
        hashTagCollectionView.showsHorizontalScrollIndicator = false
        contentStack.isLayoutMarginsRelativeArrangement = true
        contentStack.layoutMargins = UIEdgeInsets(top: SizeConstants.Padding, left: 0, bottom: SizeConstants.Padding, right: 0)
        contentStack.addArrangedSubview(hashTagCollectionView)
        contentStack.addArrangedSubview(searchHashTagTableView)
        
        
        
        
    }
    
    
    @objc func suggestTags(_ textField : UITextField){
        let tags = boldService.searchHashtags(fromKeyword: textField.text!, atWebsite: self.currentURL)
        hashtagSelectionManager.items = [tags]
        searchHashTagTableView.reloadData()
    }
    
    func presentView(forWebsite : String){
        self.currentURL = forWebsite
        
        if let tags = storageManager.fetchObjects(fromDisk: true) as? [Tag]{
            let tags = tags.filter{
                $0.url == self.currentURL
            }
            print(tags)
            
            hashTagCollectionView.selectionManager.items = [tags.map{$0.tagName ?? String.empty}]

        }
        
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


        if let tag = item as? String{
            if let tags = storageManager.fetchObjects(fromDisk: false) as? [Tag]{
                let identifiedTags = tags.filter{
                    $0.tagName == tag
                }
                if identifiedTags.count == 0{
                    var storageDefaults = TagDefaults()
                    storageDefaults.tagName = tag
                    storageDefaults.url = self.currentURL
                    storageManager.addObject(from: storageDefaults)
                }
            }
        }
        
        for (index,cell) in hashTagCollectionView.visibleCells.enumerated(){
            cell.tag = index
        }

    }

    func selectionManager(didRemoveObject: IndexPath, item: Any) {
        self.searchHashTagTableView.reloadData()
        self.hashTagCollectionView.deleteItems(at: [didRemoveObject])
        
        
        if let tag = item as? String{
            if let tags = storageManager.dataObjects as? [Tag]{
                let identifiedTags = tags.filter{
                    $0.tagName == tag
                }
                storageManager.deleteObjects(objects: identifiedTags)
            }
        }
        
        
        for (index,cell) in hashTagCollectionView.visibleCells.enumerated(){
            cell.tag = index
        }
    }
}



