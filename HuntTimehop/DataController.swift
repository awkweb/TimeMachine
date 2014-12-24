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
    
    class func jsonParser(json: NSDictionary) -> [(name: String, tagline: String)] {
        var huntsList: [(name: String, tagline: String)] = []
        var hunt: (name: String, tagline: String)
        
        if json["posts"] != nil {
            let results: [AnyObject] = json["posts"]! as [AnyObject]
            
            for post in results {
                
                let name: String = post["name"]! as String
                let tagline: String = post["tagline"]! as String

                hunt = (name: name, tagline: tagline)
                println(hunt)
                huntsList += [hunt]
            }
        }
        return huntsList
    }
}