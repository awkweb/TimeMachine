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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var getHuntsOnDateButton: UIButton!
    
    var mainVC: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.textColor = grayD
        self.hintLabel.textColor = gray
        self.datePicker.backgroundColor = white
        self.datePicker.tintColor = grayD
        self.cancelButton.backgroundColor = blue
        self.cancelButton.tintColor = white
        self.getHuntsOnDateButton.backgroundColor = orange
        self.getHuntsOnDateButton.tintColor = white
        
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
            let daysAdded = UInt(arc4random_uniform(UInt32(kDaysBetweenDates)))
            self.datePicker.date = Date.toDate(year: 2013, month: 11, day: 24).plusDays(daysAdded)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getPostsButtonPressed(sender: UIButton) {
        self.mainVC.filterDate = self.datePicker.date
        self.dismissViewControllerAnimated(true, completion: nil)
        self.mainVC.checkForTokenAndShowPosts()
    }
}
