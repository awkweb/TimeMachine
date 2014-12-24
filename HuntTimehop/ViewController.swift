//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // PH API (REMOVE BEFORE PUSHING TO GITHUB)
    let kAccessToken = "removed"
    let kAPIKey = "removed"
    let kAPISecret = "removed"
    
    let baseURL = "https://api.producthunt.com"
    
    var apiAccessToken: String = ""
    var apiHuntsList: [(name: String, tagline: String)] = []
    
    var jsonResponse: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToken()
        getPosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Mark - PH API Calls
    
    func getToken() {
        
        let url = NSURL(string: "\(baseURL)/v1/oauth/token")
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
            
            self.jsonResponse = jsonDictionary!
            
            self.apiAccessToken = DataController.jsonTokenParser(jsonDictionary!)
            
            println(self.apiAccessToken)
        })
        
        task.resume()
    }
    
    func getPosts() {
        
        let url = NSURL(string: "\(baseURL)/v1/posts/")
        var request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var params = [
            "access_token": self.apiAccessToken,
            "days_ago": "365"
        ]
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error2) -> Void in
            
            var conversionError: NSError?
            var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &conversionError) as? NSDictionary
            
            self.jsonResponse = jsonDictionary!
            
            self.apiHuntsList = DataController.jsonPostsParser(jsonDictionary!)
            
            println(self.apiHuntsList)
        })
        
        task.resume()
    }
    
}


