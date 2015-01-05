//
//  DataController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataController {
    
    // Parse oauth token request
    class func jsonTokenParser(json: NSDictionary) -> [(accessToken: String, expiresOn: NSDate)] {
        
        var tokenList: [(accessToken: String, expiresOn: NSDate)] = []
        var token: (accessToken: String, expiresOn: NSDate)
        
        if json["access_token"] != nil {
            
            let accessToken: String = json["access_token"]! as String
            let expiresOn: NSDate = NSDate().plusDays(60)
            
            token = (accessToken: accessToken, expiresOn: expiresOn)
            tokenList += [token]
            
        }
        return tokenList
    }
    
    // Parse posts request
    class func jsonPostsParser(json: NSDictionary) -> [(id: Int, name: String, tagline: String, comments: Int, votes: Int, phURL: String, screenshot: String, makerInside: Bool, hunter: String)] {
        
        var huntsList: [(id: Int, name: String, tagline: String, comments: Int, votes: Int, phURL: String, screenshot: String, makerInside: Bool, hunter: String)] = []
        var hunt: ((id: Int, name: String, tagline: String, comments: Int, votes: Int, phURL: String, screenshot: String, makerInside: Bool, hunter: String))
        
        if json["posts"] != nil {
            let results: [AnyObject] = json["posts"]! as [AnyObject]
            
            for post in results {
                
                let id: Int = post["id"]! as Int
                let name: String = post["name"]! as String
                let tagline: String = post["tagline"]! as String
                let comments: Int = post["comments_count"]! as Int
                let votes: Int = post["votes_count"]! as Int
                let phURL: String = post["discussion_url"]! as String
                
                let screenshotDictionary = post["screenshot_url"] as NSDictionary
                let screenshot: String = screenshotDictionary["850px"]! as String
                
                let makerInside: Bool = post["maker_inside"]! as Bool
                
                let userDictionary = post["user"] as NSDictionary
                let hunter: String = userDictionary["name"]! as String

                hunt = (id: id, name: name, tagline: tagline, comments: comments, votes: votes, phURL: phURL, screenshot: screenshot, makerInside: makerInside, hunter: hunter)
                huntsList += [hunt]
            }
        }
        return huntsList
    }
}