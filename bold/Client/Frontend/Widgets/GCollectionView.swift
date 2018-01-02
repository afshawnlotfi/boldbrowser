//
//  GCollectionView.swift
//  bold
//
//  Created by Afshawn Lotfi on 12/19/17.
//  Copyright © 2017 Afshawn Lotfi. All rights reserved.
//

import UIKit

protocol GCollectionViewMoveDelegate {
    func gCollectionview(_ gCollectionview : GCollectionView, didSelectCell cell : UICollectionViewCell, atIndex : IndexPath )
    func gCollectionview(_ gCollectionview : GCollectionView, didMoveCell cell : UICollectionViewCell )
    func gCollectionview(_ gCollectionview : GCollectionView, didReleaseCell cell : UICollectionViewCell )

}



class GCollectionView:UICollectionView {
   
    private(set) var collectionIdentifier:String!
    public var isMovable = true
    private(set) var loadWebviews:Bool = true
    private let collectionLayout = UICollectionViewFlowLayout()
    public var moveDelegate:GCollectionViewMoveDelegate?
    init(identifier : String){
        super.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        let tabMoveGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveCell(_:)))
        self.addGestureRecognizer(tabMoveGesture)
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
        
            switch(gesture.state) {
            case .began:
                if let index = self.indexPathForItem(at: gesture.location(in: self)) {
                    print(index)
                    if let cell = self.cellForItem(at: index) as? GCollectionContainerCell{
                        moveDelegate?.gCollectionview(self, didSelectCell: cell, atIndex : index)
                        loadWebviews = false
                        self.scrollToItem(at: index, at: .right, animated: false)
                        self.beginInteractiveMovementForItem(at: index)

                    }
                }
            case UIGestureRecognizerState.changed:
                
                self.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
                if let index = self.indexPathForItem(at: gesture.location(in: self)) {
                    if let cell = self.cellForItem(at: index) as? GCollectionContainerCell{
                        moveDelegate?.gCollectionview(self, didMoveCell: cell)
                    }
                }
            case UIGestureRecognizerState.ended:
                if let index = self.indexPathForItem(at: gesture.location(in: self)) {
                    if let cell = self.cellForItem(at: index) as? GCollectionContainerCell{
                        moveDelegate?.gCollectionview(self, didReleaseCell: cell)
                    }
                }
                self.endInteractiveMovement()

            default:
                cancelInteractiveMovement()
            }
    }
    

    
    
    
 

    
}

