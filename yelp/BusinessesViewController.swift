//
//  BusinessesViewController.swift
//  yelp
//
//  Created by Ben Hass on 2/9/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating, FiltersViewDelegate {
    
    @IBOutlet weak var businessesTableView: UITableView!
    
    var searchController: UISearchController!
    
    let yelpConsumerKey = "TPgBiETMGcmAM_cpPz3tIQ"
    let yelpConsumerSecret = "GDjnbG7F0pxrBcXqVwSZHwzsbcA"
    let yelpToken = "5Knxmf-R8T_1IkXJn4WRoQTq7FgZ4Fst"
    let yelpTokenSecret = "byqYVwYEyYA_iduBFMBHlC7LQlY"
    
    var businesses: [Business]! = []
    var filterSettings: [String: [String]] = [
        "distance": ["40000"],
        "sort": ["0"],
        "deals": ["false"],
        "categories": [""],
    ]
    var currentSearchText = ""
    var location = "37.782193,-122.410254"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessesTableView.dataSource = self
        businessesTableView.rowHeight = UITableViewAutomaticDimension
        businessesTableView.estimatedRowHeight = 100
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        navigationItem.titleView = searchController.searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filters", style: UIBarButtonItemStyle.Plain, target: self, action: "showFiltersView")
        performSearch()
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "filtersSegue" {
            let navController = segue.destinationViewController as UINavigationController
            let filtersVC = navController.topViewController as FiltersViewController
            filtersVC.delegate = self
            filtersVC.filters.selectOptions(filterSettings)
        }
    }
    
    func showFiltersView() {
        self.performSegueWithIdentifier("filtersSegue", sender: self)
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
    
    func performSearch() {
        SVProgressHUD.show()
        
        var client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        var params = [
            "term": currentSearchText,
            "ll": location,
            "sort": filterSettings["sort"]![0],
            "category_filter": ",".join(filterSettings["categories"]!),
            "radius_filter": filterSettings["distance"]![0],
            "deals_filter": filterSettings["deals"]![0]
        ]
        
        client.search(params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businesses = Business.buildCollection(response["businesses"] as [NSDictionary])
            self.businessesTableView.reloadData()
            SVProgressHUD.dismiss()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            SVProgressHUD.dismiss()
            println(error)
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        currentSearchText = searchText
        performSearch()
    }
    
    func filtersView(viewController: FiltersViewController, didSetFilters settings: [String: [String]]) {
        self.filterSettings = settings
        performSearch()
    }

}

