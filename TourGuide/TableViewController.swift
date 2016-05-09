//
//  TableViewController.swift
//  MeetupDemo
//
//  Created by Marian OShea on 02/12/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import UIKit
import CoreLocation
import CoreSpotlight

public final class TableViewController: UITableViewController {
    var cities: [City] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Meetups"
        let dublin = City.init(name: "Dublin", location:CLLocation.init(latitude: 53.3478, longitude: -6.2597))
        let beijing = City.init(name: "Beijing", location:CLLocation.init(latitude: 39.9167, longitude: 116.3833))
        let canberra = City.init(name: "Canberra", location:CLLocation.init(latitude: -35.3075, longitude:149.1244))
        let austin = City.init(name: "Austin", location:CLLocation.init(latitude: 30.2500,longitude: -97.7500))
        cities = [dublin, beijing, canberra, austin]
        tableView.reloadData()
        
        indexAllCities()
    }
    
    
    // MARK: Indexing
    public func indexAllCities() {
        let searchableItems = cities.map { $0.searchableItem }
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems) { error in
            if let error = error {
                NSLog("Error indexing cities: \(error.localizedDescription)")
            }
        }
    }
    
    public func destroyCitiesIndexing() {
        CSSearchableIndex.defaultSearchableIndex().deleteAllSearchableItemsWithCompletionHandler { error in
            if let error = error {
                print("Error deleting index: \(error.localizedDescription)")
            }
        }
    }

    public func cityForId(id: String) -> City? {
        let city = cities.filter() {$0.name == id}.first
        return city
    }

    // MARK: - Table view data source
    
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = cities[indexPath.row].name
        return cell
    }

    // MARK: - Navigation
    
       override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destinationViewController as! ViewController
        let indexPath = tableView.indexPathForSelectedRow
        viewController.city = cities[indexPath!.row]
    }
}
