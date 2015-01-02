//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - API Variables
    let baseURL = "https://api.producthunt.com/v1"
    var apiAccessToken: [(accessToken: String, expiresOn: NSDate)] = []
    var apiHuntsList: [(id: Int, name: String, tagline: String, comments: Int, votes: Int, phURL: String, screenshot: String, makerInside: Bool, hunter: String)] = []
    var jsonResponse: NSDictionary!
    var filterDate: NSDate = NSDate().minusYears(1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.imageView.image = UIImage(named: "product-hunt-glasshole-kitty-by-jess3.png")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().objectForKey(accessToken) != nil {
            
            if Date.toString(date: (NSUserDefaults.standardUserDefaults().objectForKey(expiresOn) as NSDate)) == Date.toString(date: NSDate()) {
                self.navigationItem.title = "Select a date to travel to ->"
                getToken()
                self.tableView.hidden = true
                println("Token expired")
            }
            else {
                self.navigationItem.title = Date.toPrettyString(date: self.filterDate)
                getPosts()
                self.tableView.hidden = false
            }
        }
        else {
            self.navigationItem.title = "Select a date to travel to ->"
            getToken()
            self.tableView.hidden = true
             println("New token")
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
        if segue.identifier == "showFilterVC" {
            let filterVC: FilterViewController = segue.destinationViewController as FilterViewController
            filterVC.mainVC = self
        }
        else if segue.identifier == "showPostDetailsVC" {
            let detailVC: PostDetailsViewController = segue.destinationViewController as PostDetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisPost = self.apiHuntsList[indexPath!.row]
            detailVC.hunt = thisPost
            detailVC.mainVC = self
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as ProductCell
        
        cell.votesLabel.text = "\(self.apiHuntsList[indexPath.row].votes)"
        cell.nameLabel.text = self.apiHuntsList[indexPath.row].name
        cell.taglineLabel.text = self.apiHuntsList[indexPath.row].tagline
        cell.commentsLabel.text = "\(self.apiHuntsList[indexPath.row].comments)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apiHuntsList.count
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showPostDetailsVC", sender: self)
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
            
            println(self.jsonResponse = jsonDictionary!)
            
            // Parsing checks
            if conversionError != nil {
                println(conversionError!.localizedDescription)
                let errorString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error in parsing \(errorString)")
            }
            else {
                if jsonDictionary != nil {
                    self.jsonResponse = jsonDictionary!
                    
                    self.apiAccessToken = DataController.jsonTokenParser(jsonDictionary!)
                    
                    NSUserDefaults.standardUserDefaults().setObject(self.apiAccessToken[0].accessToken, forKey: accessToken)
                    NSUserDefaults.standardUserDefaults().setObject(self.apiAccessToken[0].expiresOn, forKey: expiresOn)
                    println(NSUserDefaults.standardUserDefaults().objectForKey(expiresOn) as NSDate)
                }
                else {
                    println("Error could not parse json")
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
                println(conversionError!.localizedDescription)
                let errorString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error in parsing \(errorString)")
            }
            else {
                if jsonDictionary != nil {
                    self.jsonResponse = jsonDictionary!
                    
                    self.apiHuntsList = DataController.jsonPostsParser(jsonDictionary!)
                    
                    if self.apiHuntsList.count == 0 {
                        self.showAlertWithText("Hey", message: "Looks like there aren't any hunts on \(Date.toPrettyString(date: self.filterDate)).", actionMessage: "Okay")
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
                else {
                    println("Error could not parse json")
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
    
}


