//
//  ProductModel.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

struct Product {
  var id: Int
  var name: String
  var tagline: String
  var comments: Int
  var votes: Int
  var phURL: String
  var screenshotUrl: String
  var makerInside: Bool
  var exclusive: Bool
  var hunter: String
  
  func formatNumberWithComma(number: NSNumber) -> String {
    let formatter = NSNumberFormatter()
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    formatter.usesGroupingSeparator = true
    return formatter.stringFromNumber(number)!
  }
  
}
