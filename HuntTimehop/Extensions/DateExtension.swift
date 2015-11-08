//
//  DateExtension.swift
//  HuntTimehop
//
//  Created by thomas on 1/2/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

extension NSDate {
  
  class func stringToDate(year year: Int, month: Int, day: Int) -> NSDate {
    let components = NSDateComponents()
    components.year = year
    components.month = month
    components.day = day
    
    let gregorianCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
    let date = gregorianCalendar!.dateFromComponents(components)
    return date!
  }
  
  class func toString(date date: NSDate) -> String {
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateStringFormatter.stringFromDate(date)
    return dateString
  }
  
  class func toPrettyString(date date: NSDate) -> String {
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "E MMM d yyyy"
    let dateString = dateStringFormatter.stringFromDate(date)
    return dateString
  }
  
  class func getRandomDateWithOrigin(origin: NSDate) -> NSDate {
    let daysBetweenFirstDayAndToday = NSDate.daysBetween(date1: origin, date2: NSDate())
    let daysAdded = UInt(arc4random_uniform(UInt32(daysBetweenFirstDayAndToday)))
    let randomDate = origin.plusDays(daysAdded)
    return randomDate
  }
  
  // Below from Alex Leite: https://github.com/al7/SwiftDateExtension
  
  func plusDays(d: UInt) -> NSDate {
    return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
  }
  
  class func daysBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
    let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: d1, toDate: d2, options: [])
    return dc.day
  }
  
  public func isLessThan(date: NSDate) -> Bool {
    return (self.compare(date) == .OrderedAscending)
  }
  
  func minusYears(y: UInt) -> NSDate {
    return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
  }
  
  func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int,
    days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> NSDate {
    let dc:NSDateComponents = NSDateComponents()
    dc.second = sec
    dc.minute = min
    dc.hour = hrs
    dc.day = d
    dc.weekOfYear = wks
    dc.month = mts
    dc.year = yrs
    return NSCalendar.currentCalendar().dateByAddingComponents(dc, toDate: self, options: [])!
  }
  
}
