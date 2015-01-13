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
    
    idLabel.textColor = UIColor.grayD()
    daysAgoLabel.textColor = UIColor.grayD()
    idUnitLabel.textColor = UIColor.gray()
    daysAgoUnitLabel.textColor = UIColor.gray()
  }
}
