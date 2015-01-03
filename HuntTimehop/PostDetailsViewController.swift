//
//  PostDetailsViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/30/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var hunterLabel: UILabel!
    @IBOutlet weak var viewOnPHButton: UIButton!
    
    var hunt: (id: Int, name: String, tagline: String, comments: Int, votes: Int, phURL: String, screenshot: String, makerInside: Bool, hunter: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Content
        self.navigationItem.title = "Details"
        
        let screenshotURL = NSURL(string: self.hunt.screenshot)
        let data = NSData(contentsOfURL: screenshotURL!)
        self.imageView.image = UIImage(data: data!)
        
        self.nameLabel.text = self.hunt.name
        self.taglineLabel.text = self.hunt.tagline
        self.votesLabel.text = "\(self.hunt.votes)"
        self.commentsLabel.text = "\(self.hunt.comments)"
        self.idLabel.text = "\(self.hunt.id)"
        self.hunterLabel.text = "via \(self.hunt.hunter)"
        
        if self.hunt.makerInside {
            self.makerLabel.hidden = false
        }
        else {
            self.makerLabel.hidden = true
        }
        
        // Set Styles
        self.nameLabel.textColor = orange
        self.taglineLabel.textColor = grayD
        self.hunterLabel.textColor = grayL
        self.votesLabel.textColor = grayD
        self.commentsLabel.textColor = grayD
        self.idLabel.textColor = grayD

        self.viewOnPHButton.backgroundColor = orange
        self.viewOnPHButton.tintColor = white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func viewOnProductHuntButtonPressed(sender: UIButton) {
        let phURL = NSURL(string: self.hunt.phURL)
        UIApplication.sharedApplication().openURL(phURL!)
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
