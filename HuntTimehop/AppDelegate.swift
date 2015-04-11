//
//  AppDelegate.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    Parse.setApplicationId(kParseID, clientKey: kParseKey)
    PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
    
    return true
  }
}

