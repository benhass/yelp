//
//  FilterOption.swift
//  yelp
//
//  Created by Ben Hass on 2/20/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class FilterOption: NSObject {
    
    var label: String
    var value: String
    var selected: Bool
    
    init(label: String, value: String, selected: Bool! = false) {
        self.label = label
        self.value = value
        self.selected = selected
    }
}