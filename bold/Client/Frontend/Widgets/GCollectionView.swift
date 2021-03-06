//
//  GCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol GCollectionViewMoveDelegate {
     func gCollectionview(_ gCollectionview : GCollectionView, didSelectCell cell : UICollectionViewCell, atIndexPath : IndexPath )
     func gCollectionview(_ gCollectionview : GCollectionView, didMoveCell cell : UICollectionViewCell, atIndexPath : IndexPath )
     func gCollectionview(_ gCollectionview : GCollectionView, didReleaseCell cell : UICollectionViewCell, atIndexPath : IndexPath )
     func gCollectionview(_ gCollectionview : GCollectionView, willSelectCell cell : UICollectionViewCell, atIndexPath : IndexPath )
}

class GCollectionView:UICollectionView {
   
    private(set) var collectionIdentifier:String!
    public var isMovable = true
    private(set) var identifier: String
    private(set) var isMovingCell:Bool = false
    private let collectionLayout = UICollectionViewFlowLayout()
    public var moveDelegate:GCollectionViewMoveDelegate?
    init(identifier : String){
        self.identifier = identifier
        super.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        let tabMoveGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveCell(_:)))
        self.addGestureRecognizer(tabMoveGesture)
        self.register(UINib(nibName: self.identifier, bundle: nil), forCellWithReuseIdentifier: self.identifier)
        collectionIdentifier = identifier
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                switch(gesture.state) {
                case .began:
                    if let indexPath = self.indexPathForItem(at: gesture.location(in: self)) {
                        if let cell = self.cellForItem(at: indexPath) as? GContainerCVCell{
                            moveDelegate?.gCollectionview(self, willSelectCell: cell, atIndexPath : indexPath)
                            self.scrollToItem(at: indexPath, at: .right, animated: false)
                            self.beginInteractiveMovementForItem(at: indexPath)
                            moveDelegate?.gCollectionview(self, didSelectCell: cell, atIndexPath : indexPath)
                            isMovingCell = true

                        }
                    }
                case UIGestureRecognizerState.changed:
                    
                    self.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
                    if let indexPath = self.indexPathForItem(at: gesture.location(in: self)) {
                        if let cell = self.cellForItem(at: indexPath) as? GContainerCVCell{
                            moveDelegate?.gCollectionview(self, didMoveCell: cell, atIndexPath : indexPath)
                        }
                    }
                case UIGestureRecognizerState.ended:
                    if let indexPath = self.indexPathForItem(at: gesture.location(in: self)) {
                        if let cell = self.cellForItem(at: indexPath) as? GContainerCVCell{
                            moveDelegate?.gCollectionview(self, didReleaseCell: cell, atIndexPath : indexPath)
                        }
                    }
                    self.endInteractiveMovement()
                    isMovingCell = false

                default:
                    cancelInteractiveMovement()
                }
        }
    }

    
    
    
 

    
}

