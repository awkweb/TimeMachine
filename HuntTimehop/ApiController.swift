//
//  ApiController.swift
//  HuntTimehop
//
//  Created by thomas on 8/27/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import Foundation

class ApiController {
  
  private let apiConstants = ApiConstants()
  private let url = "https://api.producthunt.com/v1"
  
  func getUrl() -> String {
    return url
  }
  
  func getClientOnlyAuthenticationToken(callback: (Bool?, NSError?) -> ()) {
    let url = NSURL(string: "\(getUrl())/oauth/token")
    let params = [
      "client_id": apiConstants.getKey(),
      "client_secret": apiConstants.getSecret(),
      "grant_type": "client_credentials"
    ]
    
    let request = NSMutableURLRequest(URL: url!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    do {
      request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
    } catch {
      request.HTTPBody = nil
    }
    
    let task = session.dataTaskWithRequest(request) {
      data, response, error in
      
      guard data != nil else {
        callback(nil, error)
        return
      }
      
      do {
        if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
          let apiAccessToken = DataController.jsonTokenParser(jsonDictionary)
          NSUserDefaults.standardUserDefaults().setObject(apiAccessToken[0].accessToken, forKey: accessToken)
          NSUserDefaults.standardUserDefaults().setObject(apiAccessToken[0].expiresOn, forKey: expiresOn)
          callback(true, nil)
        }
      } catch let error as NSError {
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
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(NSUserDefaults.standardUserDefaults().objectForKey(accessToken) as! String)", forHTTPHeaderField: "Authorization")
    request.addValue("api.producthunt.com", forHTTPHeaderField: "Host")
    request.HTTPBody = nil
    
    let task = session.dataTaskWithRequest(request) {
      data, response, error in
      
      guard data != nil else {
        callback(nil, error)
        return
      }
      
      do {
        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
        let apiHuntsList = DataController.jsonPostsParser(jsonDictionary!)
        callback(apiHuntsList, nil)
      } catch let error as NSError {
        callback(nil, error)
      }
    }
    task.resume()
  }
  
}
