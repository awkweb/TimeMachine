//
//  RandomCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class RandomCell: UITableViewCell {

    @IBOutlet weak var getRandomDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.getRandomDayLabel.textColor = orange
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
