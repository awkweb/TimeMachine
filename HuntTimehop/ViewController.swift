//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UI Elements
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // PH API (REMOVE BEFORE PUSHING TO GITHUB)
    let kAccessToken = "removed"
    let kAPIKey = "removed"
    let kAPISecret = "removed"
    
    let baseURL = "https://api.producthunt.com/v1"
    
    var apiAccessToken: [(accessToken: String, expiresIn: Int)] = []
    var apiHuntsList: [(name: String, tagline: String, votes: Int, comments: Int, url: String)] = []
    
    var jsonResponse: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToken()
        
        self.datePicker.minimumDate = Date.toDate(year: 2013, month: 11, day: 24)
        self.datePicker.maximumDate = NSDate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getPostsButtonPressed(sender: UIButton) {
        println("getPostsButtonPressed")
        getPosts()
    }
    
    // MARK - UITableViewDataSource
    
    
    // MARK - UITableViewDelegate

    
    // MARK - PH API Calls
    
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
        
        let url = NSURL(string: "\(baseURL)/posts/")
        var request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var params = [
            "access_token": self.apiAccessToken[0].accessToken,
            "day": Date.toString(date: self.datePicker.date)
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
                }
                else {
                    println("Error could not parse json")
                }
            }
        })
        
        task.resume()
    }
}


