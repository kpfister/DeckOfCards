//
//  Deck.swift
//  DeckOfCards
//
//  Created by Nathan on 3/29/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation

class Deck {
    
    private let kDeckId = "deck_id"
    private let kRemainingCardCount = "remaining"
    private let kShuffled = "shuffled"
    
    var deckId: String
    var shuffled: Bool
    var remainingCardCount: Int
    
    init?(dictionary: [String: AnyObject]) {
        guard let deckId = dictionary[kDeckId] as? String,
            shuffled = dictionary[kShuffled] as? Bool,
            remainingCardCount = dictionary[kRemainingCardCount] as? Int else {
                return nil
        }
        
        self.deckId = deckId
        self.shuffled = shuffled
        self.remainingCardCount = remainingCardCount
    }
}

/*
 "remaining": 52,
 "deck_id": "h92e1myv8wy6",
 "success": true,
 "shuffled": false
 */