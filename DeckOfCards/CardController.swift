//
//  CardController.swift
//  DeckOfCards
//
//  Created by Nathan on 3/29/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation

class CardController {
    
    private static func newDeckUrl() -> NSURL? {
        if let url = NSURL(string: "http://deckofcardsapi.com/api/deck/new/") {
            return url
        } else {
            return nil
        }
    }
    
    private static func shuffleDeckUrl(deckId: String) -> NSURL? {
        if let url = NSURL(string: "http://deckofcardsapi.com/api/deck/\(deckId)/shuffle/") {
            return url
        } else {
            return nil
        }
    }
    
    private static func fetchCardsUrl(deckId: String, count: Int) -> NSURL? {
        if let url = NSURL(string: "http://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=\(count)") {
            return url
        } else {
            return nil
        }
    }
    
    static func fetchNewDeck(completion: (deck: Deck?) -> Void) {
        if let url = newDeckUrl() {
            NetworkController.dataAtUrl(url) { (data) in
                if let data = data {
                    do {
                        let jsonAnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let jsonDict = jsonAnyObject as? [String: AnyObject] {
                            let deck = Deck(dictionary: jsonDict)
                            completion(deck: deck)
                        }
                    } catch {
                        print("Could not serialize data: \(error)")
                        completion(deck: nil)
                    }
                } else {
                    print("Could not retrieve data")
                    completion(deck: nil)
                }
            }
        } else {
            print("Incorrect url")
            completion(deck: nil)
        }
    }
    
    
    
    static func shuffleDeck(deck: Deck, completion: (deck: Deck?) -> Void) {
        if let url = shuffleDeckUrl(deck.deckId) {
            NetworkController.dataAtUrl(url, completion: { (data) in
                if let data = data {
                    do {
                        let jsonAnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let jsonDict = jsonAnyObject as? [String: AnyObject] {
                            let deck = Deck(dictionary: jsonDict)
                            completion(deck: deck)
                        }
                    } catch {
                        print("Could not serialize data: \(error)")
                        completion(deck: nil)
                    }
                } else {
                    print("Could not retrieve data")
                    completion(deck: nil)
                }
            })
        } else {
            print("Incorrect url")
            completion(deck: nil)
        }
    }
    
    
    static func fetchCardsForDeck(deck: Deck, count: Int, completion: (cards: [Card]) -> Void) {
        if let url = fetchCardsUrl(deck.deckId, count: count) {
            NetworkController.dataAtUrl(url, completion: { (data) in
                if let data = data {
                    do {
                        let jsonAnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let jsonDict = jsonAnyObject as? [String: AnyObject] {
                            if let cardsArray = jsonDict["cards"] as? [[String: AnyObject]] {
                                var tempCardArray = [Card]()
                                for dict in cardsArray {
                                    if let card = Card(dictionary: dict) {
                                        tempCardArray.append(card)
                                    }
                                }
                                completion(cards: tempCardArray)
                            }
                        }
                    } catch {
                        print("Could not serialize data: \(error)")
                        completion(cards: [])
                    }
                } else {
                    print("Could not retrieve data")
                    completion(cards: [])
                }
            })
        } else {
            print("Incorrect url")
            completion(cards: [])
        }
    }
}