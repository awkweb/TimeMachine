//
//  FilterViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/28/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var mainVC: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.minimumDate = Date.toDate(year: 2013, month: 11, day: 24)
        self.datePicker.maximumDate = NSDate()
        self.datePicker.date = self.mainVC.filterDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // FilterVC respond to touch events
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // Detect shake
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            let daysBetweenDates = NSDate.daysBetween(date1: Date.toDate(year: 2013, month: 11, day: 24), date2: NSDate())
            let daysAdded = UInt(arc4random_uniform(UInt32(daysBetweenDates)))
            self.datePicker.date = Date.toDate(year: 2013, month: 11, day: 24).plusDays(daysAdded)
            println(daysAdded)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getPostsButtonPressed(sender: UIButton) {
        self.mainVC.filterDate = self.datePicker.date
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
