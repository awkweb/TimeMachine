//
//  Date.swift
//  HuntTimehop
//
//  Created by thomas on 12/27/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import Foundation

class Date {
    
    class func toDate(#year: Int, month: Int, day: Int) -> NSDate {
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalendar!.dateFromComponents(components)
        
        return date!
    }
    
    class func toString(#date: NSDate) -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
    
    class func toPrettyString(#date: NSDate) -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "E MMM dd, yyyy"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}