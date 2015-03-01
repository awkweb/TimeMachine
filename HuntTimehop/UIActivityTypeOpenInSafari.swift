//
//  UIActivityTypeOpenInSafari.swift.swift
//  HuntTimehop
//
//  Created by thomas on 3/1/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class UIActivityTypeOpenInSafari: UIActivity {
  var activityURL = NSURL()
  
  override class func activityCategory() -> UIActivityCategory {
    return UIActivityCategory.Action
  }
  
  override func activityTitle() -> String? {
    return "Open In Safari"
  }
  
  override func activityImage() -> UIImage? {
    return UIImage(named: "link")
  }
  
  override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
    return true
  }
  
  override func prepareWithActivityItems(activityItems: [AnyObject]) {
    activityURL = activityItems[1] as NSURL
  }
  
  override func performActivity() {
    UIApplication.sharedApplication().openURL(activityURL)
    self.activityDidFinish(true)
  }
}
