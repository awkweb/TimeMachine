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
  
  var postsVC: PostsViewController!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    titleLabel.textColor = .grayD()
    hintLabel.textColor = .gray()
    datePicker.backgroundColor = .white()
    datePicker.tintColor = .grayD()
    cancelButton.backgroundColor = .blue()
    cancelButton.tintColor = .white()
    getHuntsOnDateButton.backgroundColor = .red()
    getHuntsOnDateButton.tintColor = .white()
        
    datePicker.minimumDate = postsVC.activeCategory.originDate
    datePicker.maximumDate = NSDate()
    datePicker.date = postsVC.filterDate
  }
  
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if motion == .MotionShake {
      postsVC.filterDate = NSDate.getRandomDateWithOrigin(postsVC.activeCategory.originDate)
      dismissViewControllerAnimated(true, completion: nil)
      postsVC.authenticateAndGetPosts()
    }
  }
  
  @IBAction func cancelButtonPressed(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func getPostsButtonPressed(sender: UIButton) {
    postsVC.filterDate = datePicker.date
    dismissViewControllerAnimated(true, completion: nil)
    postsVC.authenticateAndGetPosts()
  }
  
}
