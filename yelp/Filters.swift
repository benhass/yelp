//
//  Filters.swift
//  yelp
//
//  Created by Ben Hass on 2/10/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class Filters: NSObject {
    
    var currentFilters: [Filter]
    
    var defaultFilters: [Filter] = [
        Filter(label: "Distance", name: "distance", options: [
            FilterOption(label: "0.3 Miles", value: "480"),
            FilterOption(label: "1 Mile", value: "1600"),
            FilterOption(label: "5 Miles", value: "8000"),
            FilterOption(label: "10 Miles", value: "16000"),
            FilterOption(label: "25 Miles", value: "40000")
            ],
            type: FilterType.Single
        ),
        Filter(label: "Sort", name: "sort", options: [
            FilterOption(label: "Best Match", value: "0"),
            FilterOption(label: "Distance", value: "1"),
            FilterOption(label: "Highest Rated", value: "2"),
            ],
            type: FilterType.Single
        ),
        Filter(label: "Deals", name: "deals", options: [
            FilterOption(label: "Only show businesses offering deals", value: "true"),
            FilterOption(label: "Show all businesses", value: "false")
            ],
            type: FilterType.Single
        ),
        Filter(label: "Categories", name: "categories", options: [
            FilterOption(label: "Fitness & Instruction", value: "fitness"),
            FilterOption(label: "Parks", value: "parks"),
            FilterOption(label: "Soccer", value: "football"),
            FilterOption(label: "Arts & Entertainment", value: "arts"),
            FilterOption(label: "Food", value: "food"),
            FilterOption(label: "Restaurants", value: "restaurants")
            ],
            type: FilterType.Multiple
        )
    ]
    
    override init() {
        self.currentFilters = defaultFilters
    }
    
    var selectedOptions: [String: [String]] {
        var settings = ["": [""]]
        
        for filter in currentFilters {
            var selectedFilters = filter.options.filter({ $0.selected })
            settings[filter.name] = selectedFilters.map({ $0.value })
        }
        return settings
    }
    
    func selectOptions(dictionary: [String: [String]]) {
        for filter in currentFilters {
            for filterOption in filter.options {
                var values = dictionary[filter.name]! as [String]
                if contains(values, filterOption.value) {
                    filterOption.selected = true
                }
            }
        }
    }
}