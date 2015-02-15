//
//  ViewController.swift
//  yelp
//
//  Created by Ben Hass on 2/9/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var businessesTableView: UITableView!
    
    var searchController: UISearchController!
    var lastSearchText: String?
    
    let yelpConsumerKey = "TPgBiETMGcmAM_cpPz3tIQ"
    let yelpConsumerSecret = "GDjnbG7F0pxrBcXqVwSZHwzsbcA"
    let yelpToken = "5Knxmf-R8T_1IkXJn4WRoQTq7FgZ4Fst"
    let yelpTokenSecret = "byqYVwYEyYA_iduBFMBHlC7LQlY"

    var businesses: [Business]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        businessesTableView.dataSource = self
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense.  Should set probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        businessesTableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        businessesTableView.rowHeight = UITableViewAutomaticDimension
        businessesTableView.estimatedRowHeight = 100 // fixes rotation bug
        
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
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    func performSearch(term: String = "") {
        SVProgressHUD.show()

        var client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(term, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businesses = Business.buildCollection(response["businesses"] as [NSDictionary])
            self.businessesTableView.reloadData()
            SVProgressHUD.dismiss()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            SVProgressHUD.dismiss()
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        if searchText != lastSearchText {
            self.performSearch(term: searchText)
            self.businessesTableView.reloadData()
            self.lastSearchText = searchText
        }
    }

}

