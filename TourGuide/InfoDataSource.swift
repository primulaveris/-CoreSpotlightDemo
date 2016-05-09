//
//  InfoDataSource.swift
//  TourGuide
//
//  Created by Marian O'Shea on 01/09/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import Foundation
import CoreLocation

public protocol InfoDataSource {
    func infoForCoordinates(coordinates: CLLocationCoordinate2D, checkinDate: NSDate, lengthOfStay: Int, completion:(data: [InfoItem]?, error: NSError?) -> Void)
}

extension InfoDataSource {
    public func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let loadDataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else {
                completion(data: data, error: nil)
            }
        }
        
        loadDataTask.resume()
    }
}