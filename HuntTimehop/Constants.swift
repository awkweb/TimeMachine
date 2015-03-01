//
//  Constants.swift
//  HuntTimehop
//
//  Created by thomas on 2/28/15.
//  Copyright (c) 2015 thomas. All rights reserved.
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
let version = "1.1.0"