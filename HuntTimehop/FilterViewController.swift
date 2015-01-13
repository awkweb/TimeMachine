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
    
    titleLabel.textColor = UIColor.grayD()
    hintLabel.textColor = UIColor.gray()
    datePicker.backgroundColor = UIColor.white()
    datePicker.tintColor = UIColor.grayD()
    cancelButton.backgroundColor = UIColor.blue()
    cancelButton.tintColor = UIColor.white()
    getHuntsOnDateButton.backgroundColor = UIColor.orange()
    getHuntsOnDateButton.tintColor = UIColor.white()
    
    datePicker.minimumDate = Date.toDate(year: 2013, month: 11, day: 24)
    datePicker.maximumDate = NSDate()
    datePicker.date = mainVC.filterDate
  }
  
  // Detect shake
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
    if motion == .MotionShake {
      mainVC.getRandomDate()
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  @IBAction func cancelButtonPressed(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func getPostsButtonPressed(sender: UIButton) {
    mainVC.filterDate = datePicker.date
    dismissViewControllerAnimated(true, completion: nil)
    mainVC.checkForTokenAndShowPosts()
  }
}
