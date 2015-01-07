//
//  TitleCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var makerImageView: UIImageView!
    @IBOutlet weak var hunterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.votesLabel.textColor = gray
        self.nameLabel.textColor = orange
        self.taglineLabel.textColor = grayD
        self.commentsLabel.textColor = gray
        self.hunterLabel.textColor = gray
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
