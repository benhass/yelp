//
//  FilterCell.swift
//  yelp
//
//  Created by Ben Hass on 2/16/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionState: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
