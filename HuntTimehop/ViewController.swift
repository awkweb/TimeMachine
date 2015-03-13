//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - UI Elements
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - API Variables
  let baseURL = "https://api.producthunt.com/v1"
  var apiAccessToken: [TokenModel] = []
  var apiHuntsList: [ProductModel] = []
  var jsonResponse: NSDictionary!
  var filterDate = NSDate().minusYears(1)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    checkForTokenAndShowPosts()
    
    navigationController?.navigationBar.barTintColor = .white()
    navigationController?.navigationBar.tintColor = .orange()
    tableView.backgroundColor = .grayL()
    
    let kittyImage = UIImage(named: "kitty")
    let hiddenImageView = UIImageView(frame: CGRect(x: kScreenRect.width/2 - 25, y: -75, width: 50, height: 46))
    hiddenImageView.image = kittyImage
    tableView.addSubview(hiddenImageView)
    tableView.tableFooterView = UIView()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 80.0
    
    activityIndicator.hidesWhenStopped = true
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }
  
  // Segue to FilterViewController
  @IBAction func filterButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showFilterVC", sender: self)
  }
  
  @IBAction func aboutButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showAboutVC", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "popoverFilterVC" {
      let filterVC = segue.destinationViewController as FilterViewController
      filterVC.mainVC = self
      filterVC.modalPresentationStyle = .Popover
      filterVC.popoverPresentationController!.delegate = self
    } else if segue.identifier == "showPostDetailsVC" {
      let detailVC = segue.destinationViewController as PostDetailsViewController
      let indexPath = tableView.indexPathForSelectedRow()
      let product = apiHuntsList[indexPath!.row]
      detailVC.product = product
      detailVC.mainVC = self
    }
  }
  
  // MARK: - Helpers
  
  func checkForTokenAndShowPosts() {
    activityIndicator.startAnimating()
    tableView.hidden = true
    
    if NSUserDefaults.standardUserDefaults().objectForKey(accessToken) != nil {
      if Date.toString(date: (NSUserDefaults.standardUserDefaults().objectForKey(expiresOn) as NSDate)) == Date.toString(date: NSDate()) {
        getToken()
      } else {
        getPosts()
      }
    } else {
      getToken()
    }
  }
  
  func showAlertWithText(header: String, message: String, actionMessage: String) {
    let alert = UIAlertController(title: header, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: actionMessage, style: .Default, handler: nil))
    presentViewController(alert, animated: true, completion: nil)
  }
  
  func getRandomDate() {
    let daysAdded = UInt(arc4random_uniform(UInt32(kDaysBetweenDates)))
    filterDate = Date.toDate(year: 2013, month: 11, day: 24).plusDays(daysAdded)
    checkForTokenAndShowPosts()
  }
  
  // Detect shake and show posts
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
    if motion == .MotionShake {
      getRandomDate()
    }
  }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as ProductCell
    let buttonCell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as ButtonCell
    
    if indexPath.row == apiHuntsList.count {
      return buttonCell
    } else {
      let product = apiHuntsList[indexPath.row]
      cell.votesLabel.text = "\(product.votes)"
      cell.nameLabel.text = product.name
      cell.taglineLabel.text = product.tagline
      cell.commentsLabel.text = "\(product.comments)"
      
      if product.makerInside {
        cell.makerImageView.hidden = false
      } else if product.makerInside == false {
        cell.makerImageView.hidden = true
      }
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
      let daysAdded = UInt(arc4random_uniform(UInt32(kDaysBetweenDates)))
      let randomDate = Date.toDate(year: 2013, month: 11, day: 24).plusDays(daysAdded)
      filterDate = randomDate
      checkForTokenAndShowPosts()
    } else {
      performSegueWithIdentifier("showPostDetailsVC", sender: self)
      let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as ProductCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
    }
  }
}


// MARK: - PH API Calls
extension ViewController {
  
  // PH Client Only Authentication
  func getToken() {
    
    let url = NSURL(string: "\(baseURL)/oauth/token")
    let request = NSMutableURLRequest(URL: url!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    
    var params = [
      "client_id": kAPIKey,
      "client_secret": kAPISecret,
      "grant_type": "client_credentials"
    ]
    
    var error: NSError?
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error2) -> Void in
      
      var conversionError: NSError?
      var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &conversionError) as? NSDictionary
      
      // Parsing checks
      if conversionError != nil {
        self.showAlertWithText("Oops", message: "Unable to get posts", actionMessage: "Okay")
      } else {
        if jsonDictionary != nil {
          self.jsonResponse = jsonDictionary!
          
          self.apiAccessToken = DataController.jsonTokenParser(jsonDictionary!)
          
          NSUserDefaults.standardUserDefaults().setObject(self.apiAccessToken[0].accessToken, forKey: accessToken)
          NSUserDefaults.standardUserDefaults().setObject(self.apiAccessToken[0].expiresOn, forKey: expiresOn)
          self.getPosts()
        } else {
          self.showAlertWithText("Oops", message: "Unable to get posts", actionMessage: "Okay")
        }
      }
    })
    task.resume()
  }
  
  // PH Get Posts
  func getPosts() {
    
    let url = NSURL(string: "https://api.producthunt.com/v1/posts?day=\(Date.toString(date: filterDate))")
    let request = NSMutableURLRequest(URL: url!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "GET"
    
    var error: NSError?
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(NSUserDefaults.standardUserDefaults().objectForKey(accessToken) as String)", forHTTPHeaderField: "Authorization")
    request.addValue("api.producthunt.com", forHTTPHeaderField: "Host")
    request.HTTPBody = nil
    
    var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error2) -> Void in
      
      var conversionError: NSError?
      var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &conversionError) as? NSDictionary
      
      // Parsing checks
      if conversionError != nil {
        self.showAlertWithText("Oops", message: "Unable to get posts", actionMessage: "Okay")
      } else {
        if jsonDictionary != nil {
          self.jsonResponse = jsonDictionary!
          
          self.apiHuntsList = DataController.jsonPostsParser(jsonDictionary!)
          
          if self.apiHuntsList.count == 0 {
            self.showAlertWithText("Hey", message: "There aren't any posts on \(Date.toPrettyString(date: self.filterDate)).", actionMessage: "Okay")
          }
          
          dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.navigationItem.title = Date.toPrettyString(date: self.filterDate)
            self.tableView.reloadData()
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
            self.activityIndicator.stopAnimating()
            self.tableView.hidden = false
            if self.filterDate == Date.toDate(year: 2013, month: 11, day: 24) {
              self.showAlertWithText("Hey 😺", message: "You made it back to Product Hunt's first day!", actionMessage: "Okay")
            }
          })
        } else {
          self.showAlertWithText("Oops", message: "Unable to get posts", actionMessage: "Okay")
        }
      }
    })
    task.resume()
  }
}


// MARK: - UIPopoverPresentationControllerDelegate
extension ViewController: UIPopoverPresentationControllerDelegate {
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return .None
  }
}


