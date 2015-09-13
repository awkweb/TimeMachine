//
//  ImageCell.swift
//  HuntTimehop
//
//  Created by thomas on 1/5/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
  
  @IBOutlet weak var screenshotImageView: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    activityIndicator.hidesWhenStopped = true
  }
  
}
