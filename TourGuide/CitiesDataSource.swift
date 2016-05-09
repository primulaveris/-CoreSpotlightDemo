//
//  CitiesDataSource.swift
//  MeetupDemo
//
//  Created by Marian OShea on 07/12/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import UIKit
import CoreLocation
import CoreSpotlight

public class CitiesDataSource: NSObject {
    
    let dublin = City.init(name: "Dublin", location:CLLocation.init(latitude: 53.3478, longitude: -6.2597))
    let beijing = City.init(name: "Beijing", location:CLLocation.init(latitude: 39.9167, longitude: 116.3833))
    let canberra = City.init(name: "Canberra", location:CLLocation.init(latitude: -35.3075, longitude:149.1244))
    let austin = City.init(name: "Austin", location:CLLocation.init(latitude: 30.2500,longitude: -97.7500))
    
    public var cities: Array <City> {
        get {
            return [dublin, beijing, canberra, austin]

        }
    }

    
    
    // MARK: Indexing
    
    let array = cities
    
    let searchableItems = cities.map{ $0.searchableItem }
    
    
    CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems) { error in
    if let error = error {
    NSLog("Error indexing cities: \(error.localizedDescription)")
    }
    }
    
    
    public func destroyCitiesIndexing() {
        CSSearchableIndex.defaultSearchableIndex().deleteAllSearchableItemsWithCompletionHandler { error in
            if let error = error {
                print("Error deleting index: \(error.localizedDescription)")
            }
        }
    }
    
    
}
