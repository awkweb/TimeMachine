//
//  AboutViewController.swift
//  HuntTimehop
//
//  Created by thomas on 1/2/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    var baseArray: [[AboutModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        self.navigationItem.title = "About"
        
        // Set up tableView items
        let about1 = AboutModel(title: "Tom Meagher", url: "http://twitter.com/thomasmeagher")
        let about2 = AboutModel(title: "version", url: nil)
        
        let aboutNP1 = AboutModel(title: "Austin Condiff", url: "http://www.austincondiff.com")
        
        let aboutPH1 = AboutModel(title: "The Noun Project", url: "http://www.producthunt.com/posts/the-noun-project")
        let aboutPH2 = AboutModel(title: "Make App Icon", url: "http://www.producthunt.com/posts/make-app-icon")
        let aboutPH3 = AboutModel(title: "The Complete iOS 8 Course", url: "http://www.producthunt.com/posts/the-complete-ios8-course")
        let aboutPH4 = AboutModel(title: "Product Hunt API", url: "http://www.producthunt.com/posts/product-hunt-api-beta")
        
        var aboutArray = [about1, about2]
        var aboutNPArray = [aboutNP1]
        var aboutPHArray = [aboutPH1, aboutPH2, aboutPH3, aboutPH4]
        
        self.baseArray += [aboutArray, aboutNPArray, aboutPHArray]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.baseArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisAbout = self.baseArray[indexPath.section][indexPath.row]
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AboutCell") as AboutCell
        
        cell.itemLabel.text = thisAbout.title
        
        if thisAbout.url != nil {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.optionalLabel.hidden = true
        } else {
            cell.optionalLabel.text = "1.0.1"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseArray[section].count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Built By"
        } else if section == 1 {
            return "Icons By"
        } else {
            return "Product Hunt Products Used"
        }
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let thisAbout = self.baseArray[indexPath.section][indexPath.row]
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AboutCell") as AboutCell
        
        if thisAbout.url != nil {
            let url = NSURL(string: thisAbout.url!)!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func backBarButtonItemPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
