//
//  AppDelegate.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

// MARK: - PH API Constants (REMOVE BEFORE PUSHING TO GITHUB)
let kAPIKey = "246da01e5d0f2ce229ec3c995ea62296f31b2c56de446ff030fb31fa1d44bbca"
let kAPISecret = "6350cf5d0aa725d897105b54723604f925d59df3e76070a24f9ccb57b6c2c498"

// MARK: - NSUserDefaults Variables
var accessToken = "accessTokenKey"
var expiresOn = "expiresOnKey"

// MARK: - Other Constants
let kDaysBetweenDates = NSDate.daysBetween(date1: Date.toDate(year: 2013, month: 11, day: 24), date2: NSDate())
let kScreenRect = UIScreen.mainScreen().bounds

// MARK: - AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
  }
  
  func applicationWillTerminate(application: UIApplication) {
    
  }
}

