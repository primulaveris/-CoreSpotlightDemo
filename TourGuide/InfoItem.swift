//
//  InfoItem.swift
//  TourGuide
//
//  Created by Marian O'Shea on 31/08/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import Foundation
import CoreLocation


public class InfoItem: NSObject {

}

public final class Meetup: InfoItem {

    public var id: String?
    public var address: String?
    public var dateString:String?
    public var date:NSDate?
    public var meetupDescription: String?
    public var link: String?
    public var name: String?
    public var location: CLLocationCoordinate2D?

    init(json: Dictionary<String, AnyObject>) {
        super.init()
        if  let utcOffset = json["utc_offset"] as? Int {
            if let time = json["time"] as? Int {
                date = dateWithOffset(utcOffset, time: time)
                dateString = displayDate(date!)
            }
        }

        if  let venue = json["venue"] as? Dictionary<String, AnyObject> {
            var venuAddress: String = ""
            if let venueName = venue["name"] as? String {
                venuAddress = venueName
                if  let venueAddress1 = venue["address_1"] as? String {
                    venuAddress = "\(venuAddress), \(venueAddress1)"
                }
            }
            address = venuAddress

            if let latitude =  venue["lat"] as? CLLocationDegrees {
                if let longitude = venue["lon"] as? CLLocationDegrees {
                    location = CLLocationCoordinate2D(latitude: latitude,
                                                      longitude: longitude)
                }
            }
        }

        if let description  = json["description"] as? String {
            self.meetupDescription = description.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ").stringByReplacingOccurrencesOfString("\n", withString: " ")
        }

        if let link = json["event_url"] as? String {
            self.link = link
        }

        if let name = json["name"] as? String {
            self.name  = name
        }

        if let id = json["id"] as? String {
            self.id  = id
        }
    }

    override init() {
        super.init()
    }

    private func dateWithOffset(utcOffset:Int, time: Int) -> NSDate {
        let timeInterval = Double(time/1000) + Double(utcOffset/1000)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        return date
    }

    private func displayDate(date: NSDate) -> String {

        let dateFormatter = NSDateFormatter()

        dateFormatter.dateFormat = "EEEE, MMMM d HH:mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")

        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
    
}
