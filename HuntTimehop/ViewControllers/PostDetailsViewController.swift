//
//  PostDetailsViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/30/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var product: Product!
  var filterDate: NSDate!
  var color: UIColor!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationItem.title = "Details"
    
    tableView.tableFooterView = screenRect.width < 375.0 ?
      UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40)) : UIView() // TODO: - Necessary?
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100.0
  }
  
  @IBAction func shareBarButtonItemPressed(sender: UIBarButtonItem) {
    let nameActivityItem = "\(product.name): \(product.tagline)"
    let urlActivityItem = NSURL(string: "\(product.phURL)")!
    let activityViewController = UIActivityViewController(
      activityItems: [nameActivityItem, urlActivityItem], applicationActivities: [UIActivityTypeOpenInSafari()])
    
    activityViewController.excludedActivityTypes = [
      UIActivityTypePostToWeibo,
      UIActivityTypePrint,
      UIActivityTypeAssignToContact,
      UIActivityTypeSaveToCameraRoll,
      UIActivityTypePostToFlickr,
      UIActivityTypePostToVimeo,
      UIActivityTypePostToTencentWeibo
    ]
    
    presentViewController(activityViewController, animated: true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "modalWebVC" {
      let webVC = segue.destinationViewController as! WebViewController
      webVC.detailVC = self
      webVC.product = product
    }
  }
  
}


extension PostDetailsViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch (indexPath.row) {
    case 0:
      let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell") as! TitleTableViewCell
      titleCell.votesLabel.text = "\(product.votes)"
      titleCell.nameLabel.text = product.name
      titleCell.nameLabel.textColor = color
      titleCell.taglineLabel.text = product.tagline
      titleCell.commentsLabel.text = "\(product.comments)"
      titleCell.hunterLabel.text = "via \(product.hunter)"
      titleCell.makerImageView.hidden = product.makerInside ? false : true
      titleCell.selectionStyle = .None
      return titleCell
    case 1:
      let imageCell = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! ImageTableViewCell
      imageCell.activityIndicator.startAnimating()
      imageCell.selectionStyle = .None
      let imageQueue: dispatch_queue_t = dispatch_queue_create("filter queue", nil)
      dispatch_async(imageQueue) {
        let url = NSURL(string: self.product.screenshotURL)!
        let data = NSData(contentsOfURL: url)
        dispatch_async(dispatch_get_main_queue()) {
          if data != nil {
            imageCell.screenshotImageView.image = UIImage(data: data!)
          } else {
            imageCell.screenshotImageView.image = UIImage(named: "kitty")
            imageCell.screenshotImageView.contentMode = .Center
          }
          imageCell.activityIndicator.stopAnimating()
        }
      }
      return imageCell
    case 2:
      let statsCell = tableView.dequeueReusableCellWithIdentifier("StatsCell") as! StatsTableViewCell
      statsCell.idLabel.text = "\(product.id)"
      let daysBetweenDates = NSDate.daysBetween(date1: filterDate, date2: NSDate())
      statsCell.daysAgoLabel.text = "\(daysBetweenDates)"
      statsCell.selectionStyle = .None
      return statsCell
    default:
      let buttonCell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! ButtonTableViewCell
      buttonCell.selectionStyle = .None
      buttonCell.buttonLabel.textColor = color
      return buttonCell
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
}


extension PostDetailsViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 3 {
      performSegueWithIdentifier("modalWebVC", sender: self)
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
  }
  
}
