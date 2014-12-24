//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // PH API Access Token (REMOVE BEFORE PUSHING TO GITHUB)
    let kAccessToken = "Insert Your Access Token Here"
    
    var apiHuntsList: [(name: String, tagline: String)] = []
    
    var jsonResponse: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        makeRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeRequest() {
        
        let url = NSURL(string: "https://api.producthunt.com/v1/posts/")
        var request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var params = [
            "access_token": self.kAccessToken,
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
            
            self.apiHuntsList = DataController.jsonParser(jsonDictionary!)
            
        })
        
        task.resume()
    }
    
}


