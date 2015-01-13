//
//  PostDetailsViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/30/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
  
  // MARK: - UI Elements
  @IBOutlet weak var tableView: UITableView!
  
  var product: ProductModel!
  var mainVC: ViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationItem.title = "Details"
    
    if kScreenRect.width < 375.0 {
      tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
    } else {
      tableView.tableFooterView = UIView()
    }
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100.0
  }
  
  @IBAction func shareBarButtonItemPressed(sender: UIBarButtonItem) {
    let firstActivityItem = "\(product.name): \(product.tagline)"
    let secondActivityItem : NSURL = NSURL(string: "\(product.phURL)")!
    let activityViewController : UIActivityViewController = UIActivityViewController(
      activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
    
    activityViewController.excludedActivityTypes = [
      UIActivityTypePostToWeibo,
      UIActivityTypePrint,
      UIActivityTypeAssignToContact,
      UIActivityTypeSaveToCameraRoll,
      UIActivityTypePostToFlickr,
      UIActivityTypePostToVimeo,
      UIActivityTypePostToTencentWeibo
    ]
    
    self.presentViewController(activityViewController, animated: true, completion: nil)
  }
}


// MARK: - UITableViewDataSource
extension PostDetailsViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell") as TitleCell
    let statsCell = tableView.dequeueReusableCellWithIdentifier("StatsCell") as StatsCell
    let imageCell = tableView.dequeueReusableCellWithIdentifier("ImageCell") as ImageCell
    let buttonCell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as ButtonCell
    
    if indexPath.row == 0 {
      titleCell.votesLabel.text = "\(product.votes)"
      titleCell.nameLabel.text = product.name
      titleCell.taglineLabel.text = product.tagline
      titleCell.commentsLabel.text = "\(product.comments)"
      titleCell.hunterLabel.text = "via \(product.hunter)"
      
      if product.makerInside {
        titleCell.makerImageView.hidden = false
      } else if product.makerInside == false {
        titleCell.makerImageView.hidden = true
      }
      titleCell.selectionStyle = UITableViewCellSelectionStyle.None
      return titleCell
    } else if indexPath.row == 1 {
      imageCell.activityIndicator.startAnimating()
      imageCell.selectionStyle = UITableViewCellSelectionStyle.None
      
      let imageQueue: dispatch_queue_t = dispatch_queue_create("filter queue", nil)
      
      dispatch_async(imageQueue, { () -> Void in
        let url = NSURL(string: self.product.screenshotURL)!
        let data = NSData(contentsOfURL: url)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          if data != nil {
            imageCell.screenshotImageView.image = UIImage(data: data!)
          } else {
            imageCell.screenshotImageView.image = UIImage(named: "kitty")
            imageCell.screenshotImageView.contentMode = UIViewContentMode.Center
          }
          imageCell.activityIndicator.stopAnimating()
        })
      })
      return imageCell
    } else if indexPath.row == 2 {
      statsCell.idLabel.text = "\(product.id)"
      let daysBetweenDates = NSDate.daysBetween(date1: mainVC.filterDate, date2: NSDate())
      statsCell.daysAgoLabel.text = "\(daysBetweenDates)"
      statsCell.selectionStyle = UITableViewCellSelectionStyle.None
      return statsCell
    } else {
      return buttonCell
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
}


// MARK: - UITableViewDelegate
extension PostDetailsViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 3 {
      let url = NSURL(string: product.phURL)!
      UIApplication.sharedApplication().openURL(url)
    }
  }
}
