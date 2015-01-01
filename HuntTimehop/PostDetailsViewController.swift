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
    @IBOutlet weak var websiteButton: UIButton!
    
    var hunt: (id: Int, name: String, tagline: String, comments: Int, votes: Int, phURL: String, webURL: String, screenshot: String, makerInside: Bool, hunter: String)!
    
    var mainVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set Content
        self.navigationItem.title = self.hunt.name
        self.nameLabel.text = self.hunt.name
        self.taglineLabel.text = self.hunt.tagline
        self.votesLabel.text = "\(self.hunt.votes)"
        self.commentsLabel.text = "\(self.hunt.comments)"
        self.idLabel.text = "\(self.hunt.id)"
        self.hunterLabel.text = "via \(self.hunt.hunter)"
        
        let screenshotURL = NSURL(string: self.hunt.screenshot)
        let data = NSData(contentsOfURL: screenshotURL!)
        self.imageView.image = UIImage(data: data!)
        
        if self.hunt.makerInside {
            self.makerLabel.hidden = false
        }
        else {
            self.makerLabel.hidden = true
        }
        
        // Set Styles
        self.nameLabel.textColor = self.mainVC.orange
        self.taglineLabel.textColor = self.mainVC.grayD
        self.hunterLabel.textColor = self.mainVC.grayL
        self.votesLabel.textColor = self.mainVC.grayD
        self.commentsLabel.textColor = self.mainVC.grayD
        self.idLabel.textColor = self.mainVC.grayD

        self.viewOnPHButton.backgroundColor = self.mainVC.orange
        self.viewOnPHButton.tintColor = self.mainVC.white
        
        self.websiteButton.backgroundColor = self.mainVC.blue
        self.websiteButton.tintColor = self.mainVC.white
        self.websiteButton.setTitle("\(self.hunt.name) website", forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func viewOnProductHuntButtonPressed(sender: UIButton) {
        let phURL = NSURL(string: self.hunt.phURL)
        UIApplication.sharedApplication().openURL(phURL!)
    }
    
    @IBAction func websiteButtonPressed(sender: UIButton) {
        let webURL = NSURL(string: self.hunt.webURL)
        UIApplication.sharedApplication().openURL(webURL!)
    }
}
