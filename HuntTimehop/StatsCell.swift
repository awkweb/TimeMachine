//
//  StatsCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var daysAgoLabel: UILabel!
    @IBOutlet weak var idUnitLabel: UILabel!
    @IBOutlet weak var daysAgoUnitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.idLabel.textColor = grayD
        self.daysAgoLabel.textColor = grayD
        self.idUnitLabel.textColor = gray
        self.daysAgoUnitLabel.textColor = gray
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
