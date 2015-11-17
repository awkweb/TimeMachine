//
//  Categories.swift
//  HuntTimehop
//
//  Created by thomas on 11/6/15.
//  Copyright © 2015 thomas. All rights reserved.
//

import Foundation
import UIKit

class Category {
  var name: String!
  var color: UIColor!
  var originDate: NSDate!
  var filterDate: NSDate = NSDate().minusYears(1)
  var products: [Product] = []
  
  init(name: String, color: UIColor, originDate: NSDate) {
    self.name = name
    self.color = color
    self.originDate = originDate
  }
  
}