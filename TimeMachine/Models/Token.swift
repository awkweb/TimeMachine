//
//  TokenModel.swift
//  HuntTimehop
//
//  Created by thomas on 1/12/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

struct Token {
  var key: String
  var expiryDate: NSDate
  
  static func hasTokenExpired() -> Bool {
    let today = NSDate.toString(date: NSDate())
    return NSUserDefaults.standardUserDefaults().objectForKey(tokenKey) == nil ||
      NSDate.toString(date: (NSUserDefaults.standardUserDefaults().objectForKey(tokenExpiryDate) as! NSDate)) == today
  }
  
}
