//
//  ViewController.swift
//  yelp
//
//  Created by Ben Hass on 2/9/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var businessesTableView: UITableView!
    
    let yelpConsumerKey = "TPgBiETMGcmAM_cpPz3tIQ"
    let yelpConsumerSecret = "GDjnbG7F0pxrBcXqVwSZHwzsbcA"
    let yelpToken = "5Knxmf-R8T_1IkXJn4WRoQTq7FgZ4Fst"
    let yelpTokenSecret = "byqYVwYEyYA_iduBFMBHlC7LQlY"

    var businesses: [Business]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        businessesTableView.delegate = self
        businessesTableView.dataSource = self
        businessesTableView.rowHeight = UITableViewAutomaticDimension

        performSearch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = businessesTableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCell
        var business = businesses[indexPath.row]
        cell.nameLabel.text = business.name
        cell.distanceLabel.text = String(format: "%.2f miles", business.distanceInMiles)
        cell.reviewCountLabel.text = "\(business.reviewCount) reviews"
        cell.addressLabel.text = business.address[0]
        cell.businessImageView.setImageWithURL(business.imageUrl)
        cell.businessRatingImageView.setImageWithURL(business.ratingImageUrl)
        cell.categoriesLabel.text = business.categoryList
        
        return cell
    }
    
    func performSearch() {
        SVProgressHUD.show()

        var client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businesses = Business.buildCollection(response["businesses"] as [NSDictionary])
            self.businessesTableView.reloadData()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }

}

