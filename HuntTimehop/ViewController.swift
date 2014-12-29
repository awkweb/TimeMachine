//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // PH API (REMOVE BEFORE PUSHING TO GITHUB)
    let kAccessToken = "removed"
    let kAPIKey = "removed"
    let kAPISecret = "removed"
    
    let baseURL = "https://api.producthunt.com/v1"
    
    var apiAccessToken: [(accessToken: String, expiresIn: Int)] = []
    var apiTokenExists: Bool = false
    var apiHuntsList: [(name: String, tagline: String, votes: Int, comments: Int, url: String)] = []
    
    var jsonResponse: NSDictionary!
    
    var filterDate: String = Date.toString(date: NSDate())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getToken()
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.apiTokenExists {
            getPosts()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func filterBarButtonItemTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showFilterVC", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFilterVC" {
            let filterVC: FilterViewController = segue.destinationViewController as FilterViewController
            filterVC.mainVC = self
        }
    }
    
    
    // MARK - UITableViewDataSource
    
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
    
    
    // MARK - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    // MARK - PH API Calls
    
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
    
    func getPosts() {
        
        let url = NSURL(string: "\(self.baseURL)/posts/")
        var request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var params = [
            "access_token": self.apiAccessToken[0].accessToken,
            "day": self.filterDate
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
                    println(self.apiHuntsList)
                    
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


