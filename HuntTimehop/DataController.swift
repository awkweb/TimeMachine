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
    
    class func jsonPostsParser(json: NSDictionary) -> [(name: String, tagline: String, votes: Int, comments: Int, url: String)] {
        
        var huntsList: [(name: String, tagline: String, votes: Int, comments: Int, url: String)] = []
        var hunt: (name: String, tagline: String, votes: Int, comments: Int, url: String)
        
        if json["posts"] != nil {
            let results: [AnyObject] = json["posts"]! as [AnyObject]
            
            for post in results {
                
                let name: String = post["name"]! as String
                let tagline: String = post["tagline"]! as String
                let votes: Int = post["votes_count"]! as Int
                let comments: Int = post["comments_count"]! as Int
                let url: String = post["discussion_url"]! as String

                hunt = (name: name, tagline: tagline, votes: votes, comments: comments, url: url)
                huntsList += [hunt]
            }
        }
        return huntsList
    }
}