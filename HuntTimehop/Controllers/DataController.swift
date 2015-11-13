//
//  DataController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import Foundation
import UIKit

class DataController {
  
  class func jsonTokenParser(json: NSDictionary) -> Token? {
    var token: Token?
    if let json = json["access_token"] {
      let key: String = json as! String
      let expiryDate: NSDate = NSDate().plusDays(60)
      token = Token(key: key, expiryDate: expiryDate)
    }
    return token
  }
  
  class func jsonPostsParser(json: NSDictionary) -> [Product] {
    var products: [Product] = []
    if let json = json["posts"] {
      let posts: [AnyObject] = json as! [AnyObject]
      
      for post in posts {
        let id: Int = post["id"]! as! Int
        let name: String = post["name"]! as! String
        let tagline: String = post["tagline"]! as! String
        let comments: Int = post["comments_count"]! as! Int
        let votes: Int = post["votes_count"]! as! Int
        let phURL: String = post["discussion_url"]! as! String
        
        let screenshotDictionary = post["screenshot_url"] as! NSDictionary
        let screenshotURL: String = screenshotDictionary["850px"]! as! String
        
        let makerInside: Bool = post["maker_inside"]! as! Bool
        
        var exclusive: Bool?
        if let exclusiveDictionary = post["exclusive"] as? NSDictionary {
          let exclusiveNumber = exclusiveDictionary["exclusive"]! as! Int
          exclusive = Bool.init(exclusiveNumber)
        } else {
          exclusive = false
        }
        
        let userDictionary = post["user"] as! NSDictionary
        let hunter: String = userDictionary["name"]! as! String
        
        let product = Product(id: id, name: name, tagline: tagline, comments: comments, votes: votes, phURL: phURL, screenshotURL: screenshotURL, makerInside: makerInside, exclusive: exclusive!, hunter: hunter)
        products += [product]
      }
    }
    return products
  }
  
}
