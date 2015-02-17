//
//  FiltersViewController.swift
//  yelp
//
//  Created by Ben Hass on 2/15/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

protocol FiltersViewDelegate: class {
    func filtersView(viewController: FiltersViewController, didSetFilters filters: Filters)
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentFilters: Filters!
    
    weak var delegate: FiltersViewDelegate?
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelFilters")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply Filters", style: UIBarButtonItemStyle.Plain, target: self, action: "applyFilters")
        
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        filtersTableView.rowHeight = UITableViewAutomaticDimension
        filtersTableView.estimatedRowHeight = 100
        filtersTableView.registerNib(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelFilters() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applyFilters() {
        delegate?.filtersView(self, didSetFilters: currentFilters)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var filterName = currentFilters.filterTypes[indexPath.section] as String
        var filter = currentFilters.filters[filterName] as NSDictionary
        var filterOptions = filter["options"] as NSDictionary
        var key = filterOptions.allKeys[indexPath.row] as String

        var cell = filtersTableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.optionLabel.text = key
        var selected = currentFilters.hasOptionEnabled(filterName, optionKey: key)

        if (selected) {
            cell.optionState.image = UIImage(named: "CheckedCircle")
        } else {
            cell.optionState.image = UIImage(named: "UncheckedCircle")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var filterName = currentFilters.filterTypes[section] as String
        var filter = currentFilters.filters[filterName] as NSDictionary
        var options = filter["options"] as NSDictionary
        return options.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return currentFilters.filterTypes[section] as? String
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return currentFilters.filterTypes.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var filterName = currentFilters.filterTypes[indexPath.section] as String
        var filter = currentFilters.filters[filterName] as NSDictionary
        var filterOptions = filter["options"] as NSDictionary
        var key = filterOptions.allKeys[indexPath.row] as String
        
        currentFilters.enableOption(filterName, optionKey: key)
        filtersTableView.reloadData()
    }
}
