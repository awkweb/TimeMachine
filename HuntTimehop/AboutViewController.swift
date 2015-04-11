//
//  AboutViewController.swift
//  HuntTimehop
//
//  Created by thomas on 1/2/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  
  // MARK: - UI Elements
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var versionLabel: UILabel!
  
  var baseArray: [[AboutModel]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationItem.title = "About"
    tableView.backgroundColor = .grayL()
    versionLabel.text = "Version \(version)"
    versionLabel.textColor = .gray()
    
    // Set up tableView items
    let about0 = AboutModel(title: "Tom Meagher", url: "http://thomasmeagher.com")
    
    let aboutNP0 = AboutModel(title: "Austin Condiff", url: "http://www.austincondiff.com")
    let aboutNP1 = AboutModel(title: "Jardson Almeida", url: "https://dribbble.com/jardson")
    let aboutNP2 = AboutModel(title: "Kiran Malladi", url: "http://thenounproject.com/ichiban")
    
    let aboutPH0 = AboutModel(title: "App Screenshot Builder", url: "http://www.producthunt.com/posts/app-screenshot-builder")
    let aboutPH1 = AboutModel(title: "GitHub for Mac", url: "http://www.producthunt.com/posts/github-for-mac")
    let aboutPH2 = AboutModel(title: "Make App Icon", url: "http://www.producthunt.com/posts/make-app-icon")
    let aboutPH3 = AboutModel(title: "Product Hunt API", url: "http://www.producthunt.com/posts/product-hunt-api-beta")
    let aboutPH4 = AboutModel(title: "Sketch 3", url: "http://www.producthunt.com/posts/sketch-3")
    let aboutPH5 = AboutModel(title: "Swift", url: "http://www.producthunt.com/posts/swift")
    let aboutPH6 = AboutModel(title: "The Complete iOS 8 Course", url: "http://www.producthunt.com/posts/the-complete-ios8-course")
    let aboutPH7 = AboutModel(title: "The Noun Project", url: "http://www.producthunt.com/posts/the-noun-project")
    
    var aboutArray = [about0]
    var aboutNPArray = [aboutNP0, aboutNP1, aboutNP2]
    var aboutPHArray = [aboutPH0, aboutPH1, aboutPH2, aboutPH3, aboutPH4, aboutPH5, aboutPH6, aboutPH7]
    
    baseArray += [aboutArray, aboutNPArray, aboutPHArray]
    
    let tRexImage = UIImage(named: "trex")
    let hiddenImageView = UIImageView(frame: CGRect(x: kScreenRect.width/2 - 37.5, y: -75, width: 75, height: 75))
    hiddenImageView.image = tRexImage
    tableView.addSubview(hiddenImageView)
  }
}


// MARK: - UITableViewDataSource
extension AboutViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return baseArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let thisAbout = baseArray[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("AboutCell") as! AboutCell
    cell.itemLabel.text = thisAbout.title
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
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


// MARK: - UITableViewDelegate
extension AboutViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let thisAbout = baseArray[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("AboutCell") as! AboutCell
    let url = NSURL(string: thisAbout.url)!
    UIApplication.sharedApplication().openURL(url)
  }
}
