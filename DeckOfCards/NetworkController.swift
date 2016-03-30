//
//  NetworkController.swift
//  DeckOfCards
//
//  Created by Nathan on 3/29/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation
import UIKit

class NetworkController {
    
    static func dataAtUrl(url: NSURL, completion:(data: NSData?) -> Void) {
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, _, error) in
            if let error = error {
                print("Error getting data at url: \(error.localizedDescription)")
                completion(data: nil)
            } else {
                if let data = data {
                    completion(data: data)
                } else {
                    print("Could not retrieve data at url")
                    completion(data: nil)
                }
            }
        }
        dataTask.resume()
    }
    
    static func fetchImageAtURL(url: NSURL, completion: (image: UIImage) -> ()) {
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.URLCache = NSURLCache.sharedURLCache()
        config.requestCachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
        
        let session = NSURLSession.init(configuration: config)
        
        session.dataTaskWithURL(url) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let imageData = data{
                    let image = UIImage(data: imageData)
                    if let image = image{
                        completion(image: image)
                    }
                }
            })
            }.resume()
    }
}