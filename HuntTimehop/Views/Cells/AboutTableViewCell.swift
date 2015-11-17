//
//  AboutCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/4/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
  
  @IBOutlet weak var itemLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    itemLabel.textColor = .grayD()
    detailLabel.textColor = .gray()
  }
  
}
