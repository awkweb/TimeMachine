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
    @IBOutlet weak var viewOnPHButton: UIButton!
    
    var hunt: (id: Int, name: String, tagline: String, comments: Int, votes: Int, url: String, screenshot: String, makerInside: Bool)!
    
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
        
        let screenshotURL = NSURL(string: self.hunt.screenshot)
        let data = NSData(contentsOfURL: screenshotURL!)
        self.imageView.image = UIImage(data: data!)
        
        if self.hunt.makerInside {
            self.makerLabel.hidden = false
        }
        else {
            self.makerLabel.hidden = true
        }
        
        // Set Colors
        self.viewOnPHButton.backgroundColor = self.mainVC.orange
        self.viewOnPHButton.tintColor = self.mainVC.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func viewOnProductHuntButtonPressed(sender: UIButton) {
        let huntURL = NSURL(string: self.hunt.url)
        UIApplication.sharedApplication().openURL(huntURL!)
    }
}
