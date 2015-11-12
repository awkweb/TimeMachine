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
  
  class func jsonTokenParser(json: NSDictionary) -> [Token] {
    var tokenList: [Token] = []
    if json["access_token"] != nil {
      let accessToken: String = json["access_token"]! as! String
      let expiresOn: NSDate = NSDate().plusDays(60)
      let token = Token(accessToken: accessToken, expiresOn: expiresOn)
      tokenList += [token]
    }
    return tokenList
  }
  
  class func jsonPostsParser(json: NSDictionary) -> [Product] {
    var huntsList: [Product] = []
    if json["posts"] != nil {
      let posts: [AnyObject] = json["posts"]! as! [AnyObject]
      
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
        
        let userDictionary = post["user"] as! NSDictionary
        let hunter: String = userDictionary["name"]! as! String
        
        let hunt = Product(id: id, name: name, tagline: tagline, comments: comments, votes: votes, phURL: phURL, screenshotURL: screenshotURL, makerInside: makerInside, hunter: hunter)
        huntsList += [hunt]
      }
    }
    return huntsList
  }
  
}
