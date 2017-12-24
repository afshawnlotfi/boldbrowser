//
//  GCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit


class GCollectionView:UICollectionView {
   
    
    private(set) var collectionIdentifier:String!
    public var isMovable = true
    private let collectionLayout = UICollectionViewFlowLayout()
    
    init(identifier : String){
        super.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        self.backgroundColor = .clear
        let tabMoveGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveCell(_:)))
        self.addGestureRecognizer(tabMoveGesture)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        collectionIdentifier = identifier
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    /// Switches collection scroll direction
    ///
    /// - Parameter response: Boolean on whether to scroll vetrically
    public func horizontalScroll(_ response: Bool){
        switch response{
            case true:
                self.collectionLayout.scrollDirection = .horizontal
            case false:
                self.collectionLayout.scrollDirection = .vertical
        }
    }

    ///Callback used to move cell
    ///
    /// - Parameter gesture: Gesture used to move cell
    @objc private func moveCell(_ gesture: UILongPressGestureRecognizer) {
        
        if isMovable{
            var selectedIndex:IndexPath!
            switch(gesture.state) {
            case .began:
                guard let index = self.indexPathForItem(at: gesture.location(in: self)) else {
                    break
                }
                selectedIndex = index
                self.beginInteractiveMovementForItem(at: selectedIndex)
            case UIGestureRecognizerState.changed:
                self.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            case UIGestureRecognizerState.ended:
                if let index = selectedIndex{
                    cellReleased(at: index)
                    self.endInteractiveMovement()
                    reloadData()
                }
            default:
                cancelInteractiveMovement()
            }
        }
    }
    
    ///Callback after a cell is released
    ///
    /// - Parameter at: Index Path of cell
    func cellReleased(at: IndexPath) {}
    
    /// Callback after a cell is deleted
    ///
    /// - Parameter at: Index Path of cell
    func cellDeleted(at: [IndexPath]) {}
    
    
  
    
}

