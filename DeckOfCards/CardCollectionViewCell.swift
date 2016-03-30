//
//  CardCollectionViewCell.swift
//  DeckOfCards
//
//  Created by Nathan on 3/29/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    
    func configureCellWithCard(card: Card) {
        
        cardLabel.text = ""
        imageView.image = nil
        
        
        if let imageUrl = NSURL(string: card.imageString) {
            NetworkController.fetchImageAtURL(imageUrl, completion: { (image) in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.cardLabel.text = "\(card.value) of \(card.suit)"
                    self.imageView.image = image
                })
            })
        }
    }
}
