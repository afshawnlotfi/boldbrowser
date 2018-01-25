//
//  HashtagCVDataSource.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/23/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//


import Foundation
import UIKit

class SelectionCVDataSource: NSObject, UICollectionViewDataSource{

    private var items = [String]()
    
    override init(){
        super.init()
        self.addItem(title: "yolo")
        self.addItem(title: "yolo1")
        self.addItem(title: "yolo2")
        self.addItem(title: "yolo3")
        self.addItem(title: "yolo4")
        self.addItem(title: "yolo5")
        self.addItem(title: "yolo6")

    }
    
    private func matchingIndecies(title : String) -> [Int]{
        var indecies = [Int]()
        for (index, tag) in self.items.enumerated(){
            if tag == title {
                indecies.append(index)
            }
        }
        return indecies
    }
    
    public func addItem(title : String){
        let matching = matchingIndecies(title: title)
        if matching.count == 0{
            self.items.append(title)
        }
    }
    
    public func removeItem(title : String){
        let matching = matchingIndecies(title: title)
        if matching.count != 0{
            matching.forEach{
                self.items.remove(at: $0)
            }
        }
    }
    
    
    
    public func removeItem(atIndex : Int){
        if self.items.count  - 1 >= atIndex{
            self.items.remove(at: atIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let selectionCollectionView = collectionView as? SelectionCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectionCollectionView.identifier, for: indexPath) as! GSelectionCVCell
            cell.setTitle(title: BrowserStrings.TagSymbol + items[indexPath.row])
            cell.tag = indexPath.row
            cell.gSelectionCVCellDelegate = selectionCollectionView
            return cell
        }else{
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    
}
