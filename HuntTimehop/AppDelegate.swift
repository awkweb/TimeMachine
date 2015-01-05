//
//  AppDelegate.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

// MARK: - PH API Contstants (REMOVE BEFORE PUSHING TO GITHUB)
let kAPIKey = "XXX"
let kAPISecret = "YYY"

// MARK: - NSUserDefaults Variables
var accessToken = "accessTokenKey"
var expiresOn = "expiresOnKey"

// MARK: - Colors
let orange = UIColor(red: (218/255.0), green: (85/255.0), blue: (47/255.0), alpha: 1.0)
let green = UIColor(red: (71/255.0), green: (172/255.0), blue: (129/255.0), alpha: 1.0)
let blue = UIColor(red: (0/255.0), green: (139/255.0), blue: (218/255.0), alpha: 1.0)
let grayD = UIColor(red: (83/255.0), green: (69/255.0), blue: (64/255.0), alpha: 1.0)
let grayL = UIColor(red: (153/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
let white = UIColor.whiteColor()

// MARK: - AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }
}

