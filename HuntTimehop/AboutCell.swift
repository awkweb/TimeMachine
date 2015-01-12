//
//  AboutCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/4/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.itemLabel.textColor = UIColor.grayD()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
