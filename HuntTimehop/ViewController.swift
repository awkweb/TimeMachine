//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - API Variables
    let baseURL = "https://api.producthunt.com/v1"
    var apiAccessToken: [(accessToken: String, expiresOn: NSDate)] = []
    var apiHuntsList: [ProductModel] = []
    var jsonResponse: NSDictionary!
    var filterDate: NSDate = NSDate().minusYears(1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationController?.navigationBar.barTintColor = white
        self.navigationController?.navigationBar.tintColor = orange
        self.tableView.backgroundColor = grayL
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().objectForKey(accessToken) != nil {
            
            if Date.toString(date: (NSUserDefaults.standardUserDefaults().objectForKey(expiresOn) as NSDate)) == Date.toString(date: NSDate()) {
                while NSUserDefaults.standardUserDefaults().objectForKey(accessToken) === nil {
                    getToken()
                }
                getPosts()
            } else {
                getPosts()
            }
        } else {
            while NSUserDefaults.standardUserDefaults().objectForKey(accessToken) === nil {
                getToken()
            }
            getPosts()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Segue to FilterViewController
    @IBAction func filterButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showFilterVC", sender: self)
    }
    
    @IBAction func aboutButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAboutVC", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverFilterVC" {
            let filterVC: FilterViewController = segue.destinationViewController as FilterViewController
            filterVC.mainVC = self
            filterVC.modalPresentationStyle = UIModalPresentationStyle.Popover
            filterVC.popoverPresentationController!.delegate = self
        } else if segue.identifier == "showPostDetailsVC" {
            let detailVC: PostDetailsViewController = segue.destinationViewController as PostDetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisPost = self.apiHuntsList[indexPath!.row]
            detailVC.hunt = thisPost
            detailVC.mainVC = self
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ProductCell") as ProductCell
        let randomCell = self.tableView.dequeueReusableCellWithIdentifier("RandomCell") as RandomCell
        
        if indexPath.row == self.apiHuntsList.count {
            return randomCell
        } else {
            let thisHunt = self.apiHuntsList[indexPath.row]
            cell.votesLabel.text = "\(thisHunt.votes)"
            cell.nameLabel.text = thisHunt.name
            cell.taglineLabel.text = thisHunt.tagline
            cell.commentsLabel.text = "\(thisHunt.comments)"
            
            if thisHunt.makerInside {
                cell.makerImageView.hidden = false
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apiHuntsList.count + 1
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.apiHuntsList.count {
            let daysAdded = UInt(arc4random_uniform(UInt32(kDaysBetweenDates)))
            let randomDate = Date.toDate(year: 2013, month: 11, day: 24).plusDays(daysAdded)
            filterDate = randomDate
            getPosts()
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        } else {
            self.performSegueWithIdentifier("showPostDetailsVC", sender: self)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ProductCell") as ProductCell

        if indexPath.row == self.apiHuntsList.count {
            return 90
        } else {
            let thisHunt = self.apiHuntsList[indexPath.row]
            
            if countElements(thisHunt.tagline) <= 34 {
                return 80
            } else {
                return 90
            }
        }
    }
    
    // MARK: - PH API Calls
    
    // PH Client Only Authentication
    func getToken() {
        
        let url = NSURL(string: "\(self.baseURL)/oauth/token")
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
            var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &conversionError) as? NSDictionary
            
            // Parsing checks
            if conversionError != nil {
                self.showAlertWithText("Error in parsing token", message: "Quit the app and try again", actionMessage: "Okay")
            } else {
                if jsonDictionary != nil {
                    self.jsonResponse = jsonDictionary!
                    
                    self.apiAccessToken = DataController.jsonTokenParser(jsonDictionary!)
                    
                    NSUserDefaults.standardUserDefaults().setObject(self.apiAccessToken[0].accessToken, forKey: accessToken)
                    NSUserDefaults.standardUserDefaults().setObject(self.apiAccessToken[0].expiresOn, forKey: expiresOn)
                } else {
                    self.showAlertWithText("Error could not parse json", message: "Quit the app and try again", actionMessage: "Okay")
                }
            }
        })
        task.resume()
    }
    
    // PH Get Posts
    func getPosts() {
        
        let url = NSURL(string: "\(self.baseURL)/posts/")
        var request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var params = [
            "access_token": NSUserDefaults.standardUserDefaults().objectForKey(accessToken) as String,
            "day": Date.toString(date: self.filterDate)
        ]
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error2) -> Void in
            
            var conversionError: NSError?
            var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &conversionError) as? NSDictionary
            
            // Parsing checks
            if conversionError != nil {
                self.showAlertWithText("Error in parsing posts", message: "Quit the app and try again", actionMessage: "Okay")
            } else {
                if jsonDictionary != nil {
                    self.jsonResponse = jsonDictionary!
                    
                    self.apiHuntsList = DataController.jsonPostsParser(jsonDictionary!)
                    
                    if self.apiHuntsList.count == 0 {
                        self.showAlertWithText("Hey", message: "Looks like there aren't any posts on \(Date.toPrettyString(date: self.filterDate)).", actionMessage: "Okay")
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.navigationItem.title = Date.toPrettyString(date: self.filterDate)
                        self.tableView.reloadData()
                    })
                } else {
                    self.showAlertWithText("Error could not parse json", message: "Quit the app and try again", actionMessage: "Okay")
                }
            }
        })
        task.resume()
    }
    
    // MARK: - Helpers
    
    func showAlertWithText(header: String, message: String, actionMessage: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: actionMessage, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}


