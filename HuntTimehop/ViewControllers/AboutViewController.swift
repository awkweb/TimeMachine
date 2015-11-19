//
//  AboutViewController.swift
//  HuntTimehop
//
//  Created by thomas on 1/2/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var baseArray: [[About]] = []
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationItem.title = "About"
    tableView.backgroundColor = .grayL()
    
    let tRexImage = UIImage(named: "trex")
    let hiddenImageView = UIImageView(frame: CGRect(x: screenRect.width/2 - 37.5, y: -75, width: 75, height: 75))
    hiddenImageView.image = tRexImage
    tableView.addSubview(hiddenImageView)
    
    let about0 = About(title: "Tom Meagher", detail:  "@thomasmeagher", url: "http://thomasmeagher.com")
    let about1 = About(title: "Version", detail: version, url: nil)
    
    let aboutNP0 = About(title: "Austin Condiff", detail: nil, url: "http://www.austincondiff.com")
    let aboutNP1 = About(title: "Jardson Almeida", detail: nil, url: "https://dribbble.com/jardson")
    let aboutNP2 = About(title: "Kiran Malladi", detail: nil, url: "http://thenounproject.com/ichiban")
    
    let aboutPH0 = About(title: "App Screenshot Builder", detail: nil, url: "http://www.producthunt.com/posts/app-screenshot-builder")
    let aboutPH1 = About(title: "GitHub for Mac", detail: nil, url: "http://www.producthunt.com/posts/github-for-mac")
    let aboutPH2 = About(title: "Make App Icon", detail: nil, url: "http://www.producthunt.com/posts/make-app-icon")
    let aboutPH3 = About(title: "Product Hunt API", detail: nil, url: "http://www.producthunt.com/posts/product-hunt-api-beta")
    let aboutPH4 = About(title: "Sketch 3", detail: nil, url: "http://www.producthunt.com/posts/sketch-3")
    let aboutPH5 = About(title: "Swift", detail: nil, url: "http://www.producthunt.com/posts/swift")
    let aboutPH6 = About(title: "The Complete iOS 8 Course", detail: nil, url: "http://www.producthunt.com/posts/the-complete-ios8-course")
    let aboutPH7 = About(title: "The Noun Project", detail: nil, url: "http://www.producthunt.com/posts/the-noun-project")
    
    let aboutArray = [about0, about1]
    let aboutNPArray = [aboutNP0, aboutNP1, aboutNP2]
    let aboutPHArray = [aboutPH0, aboutPH1, aboutPH2, aboutPH3, aboutPH4, aboutPH5, aboutPH6, aboutPH7]
    
    baseArray += [aboutArray, aboutNPArray, aboutPHArray]
  }
  
}


extension AboutViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return baseArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let thisAbout = baseArray[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("AboutTableViewCell") as! AboutTableViewCell
    cell.itemLabel.text = thisAbout.title
    if let detail = thisAbout.detail {
      cell.detailLabel.text = detail
    } else {
      cell.detailLabel.hidden = true
    }
    if thisAbout.url != nil {
      cell.accessoryType = .DisclosureIndicator
    }
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return baseArray[section].count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch (section) {
    case 0:
      return "Built By"
    case 1:
      return "Icons By"
    default:
      return "Products Used"
    }
  }
  
}


extension AboutViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let thisAbout = baseArray[indexPath.section][indexPath.row]
    if let url = thisAbout.url {
      let url = NSURL(string: url)!
      UIApplication.sharedApplication().openURL(url)
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}
