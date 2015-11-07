//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  let apiController = ApiController()
  var apiHuntsList: [ProductModel] = []
  var filterDate = NSDate().minusYears(1)
  
  var reloadImageView = UIImageView()
  var reloadButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    authenticateAndGetPosts()
    
    navigationController?.navigationBar.barTintColor = .white()
    navigationController?.navigationBar.tintColor = .orange()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    tableView.backgroundColor = .grayL()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 80.0
    
    let kittyImage = UIImage(named: "kitty")
    let hiddenImageView = UIImageView(frame: CGRect(x: screenRect.width/2 - 25, y: -75, width: 50, height: 46))
    hiddenImageView.image = kittyImage
    tableView.addSubview(hiddenImageView)
    tableView.tableFooterView = UIView() // TODO: Remove?
    
    reloadImageView = UIImageView(frame: CGRect(x: screenRect.width/2 - 25, y: screenRect.height/2 - 65, width: 50, height: 46))
    reloadImageView.image = kittyImage
    reloadImageView.hidden = true
    view.addSubview(reloadImageView)
    
    reloadButton = UIButton(frame: CGRect(x: screenRect.width/2 - 70, y: screenRect.height/2, width: 140, height: 36))
    reloadButton.setTitle("Reload Posts", forState: .Normal)
    reloadButton.titleLabel!.font = UIFont.boldSystemFontOfSize(16)
    reloadButton.tintColor = .white()
    reloadButton.backgroundColor = .orange()
    reloadButton.layer.cornerRadius = reloadButton.frame.height/2
    reloadButton.addTarget(self, action: "reloadButtonPressed:", forControlEvents: .TouchUpInside)
    reloadButton.hidden = true
    view.addSubview(reloadButton)
    
    tableView.reloadData()
  }
  
  @IBAction func filterButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showFilterVC", sender: self)
  }
  
  @IBAction func aboutButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showAboutVC", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "popoverFilterVC" {
      let filterVC = segue.destinationViewController as! FilterViewController
      filterVC.mainVC = self
      filterVC.modalPresentationStyle = .Popover
      filterVC.popoverPresentationController!.delegate = self
    } else if segue.identifier == "showPostDetailsVC" {
      let detailVC = segue.destinationViewController as! PostDetailsViewController
      let indexPath = tableView.indexPathForSelectedRow
      let product = apiHuntsList[indexPath!.row]
      detailVC.product = product
      detailVC.mainVC = self
    }
  }
  
  func authenticateAndGetPosts() {
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    tableView.hidden = true
    reloadImageView.hidden = true
    reloadButton.hidden = true
    let today = NSDate.toString(date: NSDate())
    
    if NSUserDefaults.standardUserDefaults().objectForKey(accessToken) == nil ||
      NSDate.toString(date: (NSUserDefaults.standardUserDefaults().objectForKey(expiresOn) as! NSDate)) == today {
      apiController.getClientOnlyAuthenticationToken {
        success, error in
        if (error != nil) {
          self.showAlertWithHeaderTextAndMessage("Oops :(", message: "\(error!.localizedDescription)", actionMessage: "Okay")
        } else {
          self.apiController.getPostsForCategoryAndDate("tech", date: self.filterDate) {
            objects, error in
            if let objects = objects as [ProductModel]! {
              self.apiHuntsList = objects
              self.displayPostsInTableView()
            } else {
              self.showAlertWithHeaderTextAndMessage("Oops :(", message: "\(error!.localizedDescription)", actionMessage: "Okay")
            }
          }
        }
      }
    } else {
      self.apiController.getPostsForCategoryAndDate("tech", date: self.filterDate) {
        objects, error in
        if let objects = objects as [ProductModel]! {
          self.apiHuntsList = objects
          self.displayPostsInTableView()
        } else {
          self.displayReloadButtonForError(error)
        }
      }
    }
  }
  
  func displayPostsInTableView() {
    dispatch_async(dispatch_get_main_queue()) {
      if self.apiHuntsList.count == 0 {
        self.showAlertWithHeaderTextAndMessage("Hey",
          message: "There aren't any posts on \(NSDate.toPrettyString(date: self.filterDate)).", actionMessage: "Okay")
      }
      if self.filterDate == NSDate.stringToDate(year: 2013, month: 11, day: 24) {
        self.showAlertWithHeaderTextAndMessage("Hey 😺",
          message: "You made it back to Product Hunt's first day!", actionMessage: "Okay")
      }
      self.navigationItem.title = NSDate.toPrettyString(date: self.filterDate)
      self.tableView.reloadData()
      self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0),
        atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
      self.activityIndicator.stopAnimating()
      self.tableView.hidden = false
    }
  }
  
  func displayReloadButtonForError(error: NSError?) {
    dispatch_async(dispatch_get_main_queue()) {
      if let error = error {
        self.showAlertWithHeaderTextAndMessage("Oops :(", message: "\(error.localizedDescription)", actionMessage: "Okay")
      }
      self.activityIndicator.stopAnimating()
      self.reloadImageView.hidden = false
      self.reloadButton.hidden = false
    }
  }
  
  func reloadButtonPressed(sender: UIButton!) {
    authenticateAndGetPosts()
  }
  
  func showAlertWithHeaderTextAndMessage(header: String, message: String, actionMessage: String) {
    let alert = UIAlertController(title: header, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: actionMessage, style: .Default, handler: nil))
    presentViewController(alert, animated: true, completion: nil)
  }
  
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if motion == .MotionShake {
      filterDate = NSDate.getRandomDate()
      authenticateAndGetPosts()
    }
  }
  
}


extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.row == apiHuntsList.count {
      let buttonCell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! ButtonCell
      return buttonCell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductCell
      let product = apiHuntsList[indexPath.row]
      cell.votesLabel.text = "\(product.votes)"
      cell.nameLabel.text = product.name
      cell.taglineLabel.text = product.tagline
      cell.commentsLabel.text = "\(product.comments)"
      cell.makerImageView.hidden = product.makerInside ? false : true
      return cell
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return apiHuntsList.count + 1
  }
  
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == self.apiHuntsList.count {
      filterDate = NSDate.getRandomDate()
      authenticateAndGetPosts()
    } else {
      performSegueWithIdentifier("showPostDetailsVC", sender: self)
      let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}


// MARK: - UIPopoverPresentationControllerDelegate
extension ViewController: UIPopoverPresentationControllerDelegate {
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return .None
  }
  
}
