//
//  FiltersViewController.swift
//  yelp
//
//  Created by Ben Hass on 2/15/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelFilters")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply Filters", style: UIBarButtonItemStyle.Plain, target: self, action: "applyFilters")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelFilters() {
        dismissModal()
    }
    
    func applyFilters() {
        dismissModal()
    }
    
    func dismissModal() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
