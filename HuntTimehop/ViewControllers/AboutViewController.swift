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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationItem.title = "About"
    tableView.backgroundColor = .grayL()
    
    let about0 = About(title: "Built By", detail:  "@thomasmeagher", url: "http://thomasmeagher.com")
    let about1 = About(title: "Version", detail: version, url: nil)
    let about2 = About(title: "Support", detail: nil, url: "https://meagher.typeform.com/to/TMUHaE")
    
    let aboutPH0 = About(title: "App Screenshot Builder", detail: nil, url: "http://www.producthunt.com/posts/app-screenshot-builder")
    let aboutPH1 = About(title: "GitHub for Mac", detail: nil, url: "http://www.producthunt.com/posts/github-for-mac")
    let aboutPH2 = About(title: "Make App Icon", detail: nil, url: "http://www.producthunt.com/posts/make-app-icon")
    let aboutPH3 = About(title: "Product Hunt API", detail: nil, url: "http://www.producthunt.com/posts/product-hunt-api-beta")
    let aboutPH4 = About(title: "Sketch 3", detail: nil, url: "http://www.producthunt.com/posts/sketch-3")
    let aboutPH5 = About(title: "Swift", detail: nil, url: "http://www.producthunt.com/posts/swift")
    let aboutPH6 = About(title: "The Complete iOS 8 Course", detail: nil, url: "http://www.producthunt.com/posts/the-complete-ios8-course")
    let aboutPH7 = About(title: "The Noun Project", detail: nil, url: "http://www.producthunt.com/posts/the-noun-project")
    
    let aboutNP0 = About(title: "Anton Scherbik", detail: "@ascherbik", url: "https://twitter.com/AScherbik")
    let aboutNP1 = About(title: "Austin Condiff", detail: "@austincondiff", url: "https://twitter.com/austincondiff")
    let aboutNP2 = About(title: "Jardson Almeida", detail: "@heyjardson", url: "https://twitter.com/HeyJardson")
    
    /* Others that have contributed icons and are not on Twitter
    let aboutNP3 = About(title: "Gediminas Baltaduonis", detail: nil, url: "https://dribbble.com/Baltaduonis")
    let aboutNP4 = About(title: "Leyla Jacqueline", detail: nil, url: "https://thenounproject.com/leyla6")
    let aboutNP5 = About(title: "Lucas Olaerts", detail: nil, url: "https://thenounproject.com/olaerts.lucas")
    let aboutNP6 = About(title: "Sridharan S", detail: nil, url: "https://thenounproject.com/Sniper")
    */
    
    let aboutArray = [about0, about1, about2]
    let aboutPHArray = [aboutPH0, aboutPH1, aboutPH2, aboutPH3, aboutPH4, aboutPH5, aboutPH6, aboutPH7]
    let aboutNPArray = [aboutNP0, aboutNP1, aboutNP2]
    
    baseArray += [aboutArray, aboutPHArray, aboutNPArray]
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
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return baseArray[section].count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch (section) {
    case 0:
      return "General"
    case 1:
      return "Products Used"
    default:
      return "Acknowledgments"
    }
  }
  
  func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
    header.textLabel!.textColor = .gray()
    header.textLabel!.font = UIFont.systemFontOfSize(14)
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
