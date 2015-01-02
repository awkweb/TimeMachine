//
//  DateExtension.swift
//  HuntTimehop
//
//  Created by thomas on 1/2/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

// From Alex Leite: https://github.com/al7/SwiftDateExtension
extension NSDate {
    
    func plusDays(d: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }
    
    class func daysBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay, fromDate: d1, toDate: d2, options: nil)
        return dc.day
    }
    
    func plusMonths(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }
    
    func minusYears(y: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }
    
    func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> NSDate {
        var dc:NSDateComponents = NSDateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return NSCalendar.currentCalendar().dateByAddingComponents(dc, toDate: self, options: nil)!
    }
}