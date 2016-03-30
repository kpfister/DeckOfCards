//
//  CardsCollectionViewController.swift
//  DeckOfCards
//
//  Created by Nathan on 3/29/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cardCell"

class CardsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var deck: Deck?
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CardController.fetchNewDeck { (deck) in
            self.deck = deck
            if let deck = deck {
                CardController.fetchCardsForDeck(deck, count: 52, completion: { (cards) in
                    self.cards = cards
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.collectionView?.reloadData()
                    })
                })
            }
        }
    }
    
    @IBAction func shuffleCardsButtonTapped(sender: AnyObject) {
        if let deck = deck {
            CardController.shuffleDeck(deck, completion: { (deck) in
                if let deck = deck {
                    CardController.fetchCardsForDeck(deck, count: 52, completion: { (cards) in
                        self.cards = cards
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.collectionView?.reloadData()
                        })
                    })
                }
            })
        }
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CardCollectionViewCell
        
        let card = cards[indexPath.row]
        
        cell.configureCellWithCard(card)
        
        return cell
    }
    
    // MARK: Collection view flow delegate methods
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: view.frame.width / 2 - 10, height: view.frame.height / 2 - 10)
//    }
    
}
