//
//  FilterViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/28/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var hintLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var getHuntsOnDateButton: UIButton!
  
  var mainVC: ViewController!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    titleLabel.textColor = .grayD()
    hintLabel.textColor = .gray()
    datePicker.backgroundColor = .white()
    datePicker.tintColor = .grayD()
    cancelButton.backgroundColor = .blue()
    cancelButton.tintColor = .white()
    getHuntsOnDateButton.backgroundColor = .orange()
    getHuntsOnDateButton.tintColor = .white()
    
    datePicker.minimumDate = NSDate.stringToDate(year: 2013, month: 11, day: 24)
    datePicker.maximumDate = NSDate()
    datePicker.date = mainVC.filterDate
  }
  
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if motion == .MotionShake {
      mainVC.filterDate = NSDate.getRandomDate()
      mainVC.authenticateAndGetPosts()
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  @IBAction func cancelButtonPressed(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func getPostsButtonPressed(sender: UIButton) {
    mainVC.filterDate = datePicker.date
    dismissViewControllerAnimated(true, completion: nil)
    mainVC.authenticateAndGetPosts()
  }
  
}
