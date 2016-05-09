//
//  MeetupDataSource.swift
//  TourGuide
//
//  Created by Marian O'Shea on 01/09/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import Foundation
import CoreLocation

public final class MeetupDataSource: InfoDataSource {
    
    let apiKey: String = “Your Meetup API Key”
    
    var baseURL: String {
        return "https://api.meetup.com/2/open_events.json?&sign=true&key=\(apiKey)&photo-host=public&text_format=plain&radius=smart&order=trending&page=10&desc=true"
    }
    
    public func infoForCoordinates(coordinates: CLLocationCoordinate2D, checkinDate: NSDate, lengthOfStay: Int, completion:(data: [InfoItem]?, error: NSError?) -> Void) {
        
        let endDate = checkinDate.dateByAddingTimeInterval(Double(lengthOfStay)*24*3600)
        let startDateEpoch = Int(checkinDate.timeIntervalSince1970 * 1000)
        let endDateEpoch = Int(endDate.timeIntervalSince1970 * 1000)
        
        let resourceURL = NSURL(string: "\(baseURL)&lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&time=\(startDateEpoch),\(endDateEpoch)")
        
        if let resourceURL = resourceURL {
            loadDataFromURL(resourceURL) { (data, error) in
                do {
                    let parsedObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    let json: AnyObject? = parsedObject.objectForKey("results")
                    if json == nil {
                        
                        completion(data: .None, error: NSError(.InvalidJSON))
                        return
                    }
                    let results = json as! [Dictionary<String,AnyObject>]
                    
                    if (results.count) == 0 {
                        completion(data: .None, error: nil)
                        return
                    }
                    var items: [Meetup] = []
                    
                    for item in results {
                        let meetup = Meetup.init(json: item)
                        items.append(meetup)
                    }
                    completion(data: items, error: nil)
                    
                }
                catch let error as NSError {
                    completion(data: .None, error: error)
                } catch {
                    fatalError()
                }
                
            }
        } else {
            completion(data: .None, error: NSError(.InvalidURL))
        }
    }
    
    
}

