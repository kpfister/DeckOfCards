//
//  Card.swift
//  DeckOfCards
//
//  Created by Nathan on 3/29/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation

class Card {
    
    private let kValue = "value"
    private let kSuit = "suit"
    private let kImage = "image"
    private let kCode = "code"
    
    var value: String
    var suit: String
    var imageString: String
    var code: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let value = dictionary[kValue] as? String,
        suit = dictionary[kSuit] as? String,
        imageString = dictionary[kImage] as? String,
            code = dictionary[kCode] as? String else {
                return nil
        }
        
        self.value = value
        self.suit = suit
        self.imageString = imageString
        self.code = code
    }
}


/*code : "KS"
 value : "KING"
 suit : "SPADES"
 image : "http://deckofcardsapi.com/static/img/KS.png"
 images
 svg : "http://deckofcardsapi.com/static/img/KS.svg"
 png : "http://deckofcardsapi.com/static/img/KS.png"
 */