//
//  Business.swift
//  rottentomatoes
//
//  Created by Ben Hass on 2/10/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class Business: NSObject {
    var imageUrl: NSURL = NSURL()
    var name: String = ""
    var ratingImageUrl: NSURL = NSURL()
    var reviewCount: Int = 0
    var address: [String] = [""]
    var categories: [[String]] = [[""]]
    var distanceInMeters: Float = 0.0
    
    init(dictionary: NSDictionary) {
        super.init()
        
        if var imageUrl = dictionary.valueForKey("image_url") as? String {
            self.imageUrl = NSURL(string: imageUrl)!
        } else {
            // provide defaultImageUrl
        }
        
        self.name = dictionary.valueForKey("name") as String
     
        if var ratingImageUrl = dictionary.valueForKey("rating_img_url_large") as? String {
            self.ratingImageUrl = NSURL(string: ratingImageUrl)!
        } else {
            // maybe fallback to something?
        }
        
        self.reviewCount = dictionary.valueForKey("review_count") as Int
        self.address = dictionary.valueForKeyPath("location.address") as [String]
        
        if var categories = dictionary.valueForKey("categories") as? [[String]] {
            self.categories = categories
        }
        
        self.distanceInMeters = dictionary.valueForKey("distance") as Float
    }
    
    var distanceInMiles: Float {
        return distanceInMeters * 0.000621371
    }
    
    var categoryList: String {

        return ", ".join(categories.map { $0[0] })
    }
    
    class func buildCollection(dictionaries: [NSDictionary]) -> [Business] {
        var businessCollection: [Business] = []
        
        for dictionary in dictionaries {
            businessCollection.append(Business(dictionary: dictionary))
        }
        
        return businessCollection
    }
}