//
//  Filters.swift
//  yelp
//
//  Created by Ben Hass on 2/10/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class Filters: NSObject {
    let sortOptions = [
        "Best Match"    : 0,
        "Distance"      : 1,
        "Highest Rated" : 2
    ]
    
    let distanceOptions = [
        "0.3 Miles" : 480,
        "1 Mile"    : 1600,
        "5 Miles"   : 8000,
        "10 Miles"  : 16000,
        "25 Miles"  : 40000
    ]
    
    let categoryOptions = [
        "Fitness & Instruction" : "fitness",
        "Parks"                 : "parks",
        "Soccer"                : "football",
        "Arts & Entertainment"  : "arts",
        "Food"                  : "food",
        "Restaurants"           : "restaurants"
    ]
    
    let dealOptions = [
        "Only show businesses offering deals": true,
        "Show all businesses": false
    ]

    var categories: [String] = []
    var deals = false
    var distance = 40000
    var sort = 0
    
    var filters: NSDictionary {
        return [
            "sort"     : ["options" : sortOptions,     "value": sort],
            "distance" : ["options" : distanceOptions, "value": distance],
            "category" : ["options" : categoryOptions, "value": categories],
            "deals"    : ["options" : dealOptions,     "value": deals]
        ]
    }
    
    var filterTypes: NSArray {
        return Array(filters.allKeys)
    }
    
    func hasOptionEnabled(filterType: String, optionKey: String) -> Bool {
        var optionEnabled: Bool
        var filter = filters[filterType] as NSDictionary
        var filterOptions = filter["options"] as NSDictionary
        
        switch (filterType) {
        case "deals":
            var currentValue = filter["value"] as Bool
            var optionValue = filterOptions[optionKey] as Bool
            return currentValue == optionValue ?? false
        case "category":
            var currentValuesArray = filter["value"] as [String]
            var optionValue = filterOptions[optionKey] as String
            return contains(currentValuesArray, optionValue)
        case "sort":
            var currentValue = filter["value"] as Int
            var optionValue = filterOptions[optionKey] as Int
            return currentValue == optionValue ?? false
        case "distance":
            var currentValue = filter["value"] as Int
            var optionValue = filterOptions[optionKey] as Int
            return currentValue == optionValue ?? false
        default:
            optionEnabled = false
        }
        
        return optionEnabled
    }
    
    func enableOption(filterType: String, optionKey: String) {
        var filter = filters[filterType] as NSDictionary
        var filterOptions = filter["options"] as NSDictionary
        var foundIndex: Int?
        
        switch (filterType) {
        case "deals":
            deals = filterOptions[optionKey] as Bool
        case "category":
            var category = filterOptions[optionKey] as String
            for (index, value) in enumerate(categories) {
                if value == category {
                    foundIndex = index
                }
            }
            if (foundIndex != nil) {
                categories.removeAtIndex(foundIndex!)
            } else {
                categories.append(category as String)
            }
        case "sort":
            sort = filterOptions[optionKey] as Int
        case "distance":
            distance = filterOptions[optionKey] as Int
        default:
            break
        }
    }
}