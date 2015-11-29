//
//  StatsCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var daysAgoLabel: UILabel!
  @IBOutlet weak var idUnitLabel: UILabel!
  @IBOutlet weak var daysAgoUnitLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    idLabel.textColor = .grayM()
    daysAgoLabel.textColor = .grayM()
    idUnitLabel.textColor = .gray()
    daysAgoUnitLabel.textColor = .gray()
  }
  
}
