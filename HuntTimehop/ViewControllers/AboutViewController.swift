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
  
  var baseArray: [[AboutModel]] = []
  
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
    
    let about0 = AboutModel(title: "Tom Meagher", detail:  "@thomasmeagher", url: "http://thomasmeagher.com")
    let about1 = AboutModel(title: "Version", detail: version, url: nil)
    
    let aboutNP0 = AboutModel(title: "Austin Condiff", detail: nil, url: "http://www.austincondiff.com")
    let aboutNP1 = AboutModel(title: "Jardson Almeida", detail: nil, url: "https://dribbble.com/jardson")
    let aboutNP2 = AboutModel(title: "Kiran Malladi", detail: nil, url: "http://thenounproject.com/ichiban")
    
    let aboutPH0 = AboutModel(title: "App Screenshot Builder", detail: nil, url: "http://www.producthunt.com/posts/app-screenshot-builder")
    let aboutPH1 = AboutModel(title: "GitHub for Mac", detail: nil, url: "http://www.producthunt.com/posts/github-for-mac")
    let aboutPH2 = AboutModel(title: "Make App Icon", detail: nil, url: "http://www.producthunt.com/posts/make-app-icon")
    let aboutPH3 = AboutModel(title: "Product Hunt API", detail: nil, url: "http://www.producthunt.com/posts/product-hunt-api-beta")
    let aboutPH4 = AboutModel(title: "Sketch 3", detail: nil, url: "http://www.producthunt.com/posts/sketch-3")
    let aboutPH5 = AboutModel(title: "Swift", detail: nil, url: "http://www.producthunt.com/posts/swift")
    let aboutPH6 = AboutModel(title: "The Complete iOS 8 Course", detail: nil, url: "http://www.producthunt.com/posts/the-complete-ios8-course")
    let aboutPH7 = AboutModel(title: "The Noun Project", detail: nil, url: "http://www.producthunt.com/posts/the-noun-project")
    
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
    let cell = tableView.dequeueReusableCellWithIdentifier("AboutCell") as! AboutCell
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
    if section == 0 {
      return "Built By"
    } else if section == 1 {
      return "Icons By"
    } else {
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
