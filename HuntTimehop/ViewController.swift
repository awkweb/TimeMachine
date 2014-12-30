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
    
    // MARK: - PH API (REMOVE BEFORE PUSHING TO GITHUB)
    let kAPIKey = "XXX"
    let kAPISecret = "YYY"
    
    let baseURL = "https://api.producthunt.com/v1"
    
    var apiAccessToken: [(accessToken: String, expiresIn: Int)] = []
    var apiTokenExists: Bool = false
    var apiHuntsList: [(id: Int, name: String, tagline: String, comments: Int, votes: Int, url: String, screenshot: String, makerInside: Bool)] = []
    
    var jsonResponse: NSDictionary!
    
    var filterDate: NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.apiTokenExists {
            getPosts()
        }
        else {
            getToken()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func filterButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showFilterVC", sender: self)
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
            "client_id": self.kAPIKey,
            "client_secret": self.kAPISecret,
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
                    self.apiTokenExists = true
                    println(self.apiAccessToken)
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
            "access_token": self.apiAccessToken[0].accessToken,
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
}


