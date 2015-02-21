//
//  Filter.swift
//  yelp
//
//  Created by Ben Hass on 2/20/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import Foundation

class Filter: NSObject {
    var label: String
    var name: String
    var options: [FilterOption]
    var type: FilterType
    
    init(label: String, name: String, options: [FilterOption], type: FilterType) {
        self.label = label
        self.name = name
        self.options = options
        self.type = type
    }
    
    func setSelected(filterOptionIndex: Int) {
        var filterOption = options[filterOptionIndex]
        if type == FilterType.Single {
            options.map({ $0.selected = false })
            filterOption.selected = true
        } else if type == FilterType.Multiple {
            filterOption.selected = !filterOption.selected
        }
    }
}

enum FilterType {
    case Single
    case Multiple
}