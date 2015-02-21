//
//  FiltersViewController.swift
//  yelp
//
//  Created by Ben Hass on 2/15/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

protocol FiltersViewDelegate: class {
    func filtersView(viewController: FiltersViewController, didSetFilters settings: [String: [String]])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var filters = Filters()
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
        delegate?.filtersView(self, didSetFilters: filters.selectedOptions)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var filterOption = filters.currentFilters[indexPath.section].options[indexPath.row]
        var cell = filtersTableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.optionLabel.text = filterOption.label

        if (filterOption.selected) {
            cell.optionState.image = UIImage(named: "Checked")
        } else {
            cell.optionState.image = nil
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.currentFilters[section].options.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters.currentFilters[section].label
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filters.currentFilters.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var filter = filters.currentFilters[indexPath.section]
        filter.setSelected(indexPath.row);
        filtersTableView.reloadData()
    }
}
