//
//  ApiController.swift
//  HuntTimehop
//
//  Created by thomas on 8/27/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

class ApiController {
  
  private let url = "https://api.producthunt.com/v1"
  private let key = "246da01e5d0f2ce229ec3c995ea62296f31b2c56de446ff030fb31fa1d44bbca"
  private let secret = "6350cf5d0aa725d897105b54723604f925d59df3e76070a24f9ccb57b6c2c498"
  
  func getUrl() -> String {
    return url
  }
  
  func getKey() -> String {
    return key
  }
  
  func getSecret() -> String {
    return secret
  }
  
  func getClientOnlyAuthenticationToken(callback: (Bool?, NSError?) -> ()) {
    
    let url = NSURL(string: "\(getUrl())/oauth/token")
    let request = NSMutableURLRequest(URL: url!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    
    var params = [
      "client_id": getKey(),
      "client_secret": getSecret(),
      "grant_type": "client_credentials"
    ]
    
    var error: NSError?
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
    
    var task = session.dataTaskWithRequest(request) {
      data, response, error in

      var conversionError: NSError?
      var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &conversionError) as? NSDictionary
    
      if let json = jsonDictionary {
        let apiAccessToken = DataController.jsonTokenParser(json)
        NSUserDefaults.standardUserDefaults().setObject(apiAccessToken[0].accessToken, forKey: accessToken)
        NSUserDefaults.standardUserDefaults().setObject(apiAccessToken[0].expiresOn, forKey: expiresOn)
        callback(true, nil)
      } else {
        callback(nil, error)
      }
    }
    task.resume()
  }
  
  func getPostsForDate(date: NSDate, callback: ([ProductModel]?, NSError?) -> ()) {
    let filterDate = NSDate.toString(date: date)
    let url = NSURL(string: "\(getUrl())/posts?day=\(filterDate)")
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
      
      if let json = jsonDictionary {
        let apiHuntsList = DataController.jsonPostsParser(json)
        callback(apiHuntsList, nil)
      } else {
        callback(nil, error)
      }
    }
    task.resume()
  }
  
}
