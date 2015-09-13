//
//  ProductCell.swift
//  HuntTimehop
//
//  Created by thomas on 12/28/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
  
  @IBOutlet weak var votesLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var taglineLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var makerImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    votesLabel.textColor = .gray()
    nameLabel.textColor = .grayD()
    taglineLabel.textColor = .grayD()
    commentsLabel.textColor = .gray()
  }
  
}
