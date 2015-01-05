//
//  PostDetailsViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/30/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    var hunt: ProductModel!
    var mainVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let titleCell = self.tableView.dequeueReusableCellWithIdentifier("TitleCell") as TitleCell
        let statsCell = self.tableView.dequeueReusableCellWithIdentifier("StatsCell") as StatsCell
        let imageCell = self.tableView.dequeueReusableCellWithIdentifier("ImageCell") as ImageCell
        let buttonCell = self.tableView.dequeueReusableCellWithIdentifier("ButtonCell") as ButtonCell
        
        if indexPath.row == 0 {
            titleCell.votesLabel.text = "\(self.hunt.votes)"
            titleCell.nameLabel.text = self.hunt.name
            titleCell.taglineLabel.text = self.hunt.tagline
            titleCell.hunterLabel.text = self.hunt.hunter
            return titleCell
        } else if indexPath.row == 1 {
            statsCell.idLabel.text = "\(self.hunt.id)"
            statsCell.commentsLabel.text = "\(self.hunt.comments)"
            let daysBetweenDates = NSDate.daysBetween(date1: self.mainVC.filterDate, date2: NSDate())
            statsCell.daysAgoLabel.text = "\(daysBetweenDates)"
            return statsCell
        } else if indexPath.row == 2 {
            let imageQueue: dispatch_queue_t = dispatch_queue_create("filter queue", nil)
            
            dispatch_async(imageQueue, { () -> Void in
                let url = NSURL(string: self.hunt.screenshotURL)!
                println(self.hunt.screenshotURL)
                let data = NSData(contentsOfURL: url)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if data != nil {
                        imageCell.screenshotImageView.image = UIImage(data: data!)
                    } else {
                        println("Data is nil")
                    }
                })
            })
            return imageCell
        } else {
            return buttonCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50.0
        } else if indexPath.row == 1 {
            return 50.0
        } else if indexPath.row == 2 {
            return 200.0
        } else {
            return 50.0
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 4 {
            let url = NSURL(string: self.hunt.phURL)!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    @IBAction func shareSheetButtonPressed(sender: UIBarButtonItem) {
        let firstActivityItem = "\(self.hunt.name): \(self.hunt.tagline)"
        
        let secondActivityItem : NSURL = NSURL(string: "\(self.hunt.phURL)")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
