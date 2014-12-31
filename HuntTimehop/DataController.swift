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
    class func jsonTokenParser(json: NSDictionary) -> [(accessToken: String, expiresIn: Int)] {
        
        var tokenList: [(accessToken: String, expiresIn: Int)] = []
        var token: (accessToken: String, expiresIn: Int)
        
        if json["access_token"] != nil {
            
            let accessToken: String = json["access_token"]! as String
            let expiresIn: Int = json["expires_in"]! as Int
            
            token = (accessToken: accessToken, expiresIn: expiresIn)
            tokenList += [token]
            
        }
        return tokenList
    }
    
    // Parse posts request
    class func jsonPostsParser(json: NSDictionary) -> [(id: Int, name: String, tagline: String, comments: Int, votes: Int, url: String, screenshot: String, makerInside: Bool)] {
        
        var huntsList: [(id: Int, name: String, tagline: String, comments: Int, votes: Int, url: String, screenshot: String, makerInside: Bool)] = []
        var hunt: (id: Int, name: String, tagline: String, comments: Int, votes: Int, url: String, screenshot: String, makerInside: Bool)
        
        if json["posts"] != nil {
            let results: [AnyObject] = json["posts"]! as [AnyObject]
            
            for post in results {
                
                let id: Int = post["id"]! as Int
                let name: String = post["name"]! as String
                let tagline: String = post["tagline"]! as String
                let comments: Int = post["comments_count"]! as Int
                let votes: Int = post["votes_count"]! as Int
                let url: String = post["discussion_url"]! as String
                
                let screenshotDictionary = post["screenshot_url"] as NSDictionary
                let screenshot: String = screenshotDictionary["850px"]! as String
                
                let makerInside: Bool = post["maker_inside"]! as Bool

                hunt = (id: id, name: name, tagline: tagline, comments: comments, votes: votes, url: url, screenshot: screenshot, makerInside: makerInside)
                huntsList += [hunt]
            }
        }
        return huntsList
    }
}