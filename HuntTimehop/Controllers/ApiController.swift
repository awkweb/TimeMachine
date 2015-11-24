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
  private let host = "api.producthunt.com"
  
  func getHost() -> String {
    return host
  }
  
  func getClientOnlyAuthenticationToken(callback: (Bool?, NSError?) -> ()) {
    let components = NSURLComponents()
    components.scheme = "https"
    components.host = getHost()
    components.path = "/v1/oauth/token"
    let url = components.URL
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
          let token = DataController.jsonTokenParser(jsonDictionary)!
          NSUserDefaults.standardUserDefaults().setObject(token.key, forKey: tokenKey)
          NSUserDefaults.standardUserDefaults().setObject(token.expiryDate, forKey: tokenExpiryDate)
          callback(true, nil)
        }
      } catch let error as NSError {
        callback(nil, error)
      }
    }
    task.resume()
  }
  
  func getPostsForCategoryAndDate(category: String, date: NSDate, callback: ([Product]?, NSError?) -> ()) {
    let filterDate = NSDate.toString(date: date)
    let components = NSURLComponents()
    components.scheme = "https"
    components.host = getHost()
    components.path = "/v1/categories/\(category)/posts"
    components.queryItems = [
      NSURLQueryItem(name: "day", value: "\(filterDate)")
    ]
    let url = components.URL
    
    let request = NSMutableURLRequest(URL: url!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(NSUserDefaults.standardUserDefaults().objectForKey(tokenKey) as! String)", forHTTPHeaderField: "Authorization")
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
        let products = DataController.jsonPostsParser(jsonDictionary!)
        callback(products, nil)
      } catch let error as NSError {
        callback(nil, error)
      }
    }
    task.resume()
  }
  
}
