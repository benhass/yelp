//
//  BusinessCell.swift
//  yelp
//
//  Created by Ben Hass on 2/10/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessRatingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        businessImageView.layer.masksToBounds = true
        businessImageView.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
