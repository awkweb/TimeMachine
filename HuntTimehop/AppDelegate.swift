//
//  AppDelegate.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

// MARK: - PH API Constants (REMOVE BEFORE PUSHING TO GITHUB)
let kAPIKey = "XXX"
let kAPISecret = "YYY"

// MARK: - NSUserDefaults Variables
var accessToken = "accessTokenKey"
var expiresOn = "expiresOnKey"

// MARK: - Other Constants
let kDaysBetweenDates = NSDate.daysBetween(date1: Date.toDate(year: 2013, month: 11, day: 24), date2: NSDate())
let kScreenRect = UIScreen.mainScreen().bounds

// MARK: - Colors
let orange = UIColor(red: (241/255.0), green: (73/255.0), blue: (52/255.0), alpha: 1.0)
let green = UIColor(red: (72/255.0), green: (172/255.0), blue: (130/255.0), alpha: 1.0)
let blue = UIColor(red: (0/255.0), green: (139/255.0), blue: (218/255.0), alpha: 1.0)
let grayD = UIColor(red: (64/255.0), green: (49/255.0), blue: (45/255.0), alpha: 1.0)
let gray = UIColor(red: (153/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
let grayL = UIColor(red: (237/255.0), green: (236/255.0), blue: (235/255.0), alpha: 1.0)
let white = UIColor.whiteColor()

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

