//
//  ButtonCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
  
  @IBOutlet weak var buttonLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    buttonLabel.textColor = .orange()
  }
  
}
