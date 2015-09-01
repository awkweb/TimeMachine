//
//  ApiController.swift
//  HuntTimehop
//
//  Created by thomas on 8/27/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

class ApiController {
  
  let baseURL = "https://api.producthunt.com/v1"
  
  func getClientOnlyAuthenticationToken(callback: (Bool?, NSError?) -> ()) {
    
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
    
    var task = session.dataTaskWithRequest(request) {
      data, response, error in
      
      var conversionError: NSError?
      var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &conversionError) as? NSDictionary
    
      if jsonDictionary != nil {
        let jsonResponse = jsonDictionary!
        
        let apiAccessToken = DataController.jsonTokenParser(jsonDictionary!)
        
        NSUserDefaults.standardUserDefaults().setObject(apiAccessToken[0].accessToken, forKey: accessToken)
        NSUserDefaults.standardUserDefaults().setObject(apiAccessToken[0].expiresOn, forKey: expiresOn)
        callback(true, nil)
      } else {
        callback(nil, error)
      }
      
    }
  }
  
  func getPostsForDate(date: NSDate, callback: ([ProductModel]?, NSError?) -> ()) {
    let filterDate = Date.toString(date: date)
    let url = NSURL(string: "\(baseURL)/posts?day=\(filterDate)")
    let request = NSMutableURLRequest(URL: url!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "GET"
    
    var error: NSError?
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(NSUserDefaults.standardUserDefaults().objectForKey(accessToken) as! String)", forHTTPHeaderField: "Authorization")
    request.addValue("api.producthunt.com", forHTTPHeaderField: "Host")
    request.HTTPBody = nil
    
    var task = session.dataTaskWithRequest(request) {
      data, response, error in
      
      var conversionError: NSError?
      var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &conversionError) as? NSDictionary
      
      if jsonDictionary != nil {
        let jsonResponse = jsonDictionary!
        let apiHuntsList = DataController.jsonPostsParser(jsonDictionary!)
        callback(apiHuntsList, nil)
      } else {
        callback(nil, error)
      }
    }
  }
  
}
