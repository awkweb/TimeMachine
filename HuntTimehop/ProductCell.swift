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
    @IBOutlet weak var taglineLabel: UITextView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var makerImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
