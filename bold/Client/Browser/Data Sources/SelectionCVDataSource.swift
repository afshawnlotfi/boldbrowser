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

    private var selectionManager:SelectionManager<String>
    
    
    init(selectionManager : SelectionManager<String>) {
        self.selectionManager = selectionManager
        super.init()
    }
    
    private func matchingIndecies(title : String) -> [Int]{
        var indecies = [Int]()
        for (index, tag) in self.selectionManager.items[0].enumerated(){
            if tag == title {
                indecies.append(index)
            }
        }
        return indecies
    }
    
    public func addItem(title : String){
        let matching = matchingIndecies(title: title)
        if matching.count == 0{
            self.selectionManager.addItem(item: title, section: 0)
        }
    }
    
    public func removeItem(title : String){
        let matching = matchingIndecies(title: title)
        if matching.count != 0{
            matching.forEach{
                self.selectionManager.removeItem(row: $0, section: 0)
            }
        }
    }
    
    
    
    public func removeItem(index : Int){
        if self.selectionManager.items[0].count  - 1 >= index{
            self.selectionManager.removeItem(row: index, section: 0)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.selectionManager.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectionManager.items[section].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let selectionCollectionView = collectionView as? SelectionCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectionCollectionView.identifier, for: indexPath) as! GSelectionCVCell
            cell.setTitle(title: BrowserStrings.TagSymbol + self.selectionManager.items[indexPath.section][indexPath.row])
            cell.tag = indexPath.row
            print(indexPath.row)
            cell.gSelectionCVCellDelegate = selectionCollectionView
            return cell
        }else{
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    
}
