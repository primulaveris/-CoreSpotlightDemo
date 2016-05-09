//
//  MeetupSearch.swift
//  MeetupDemo
//
//  Created by Marian OShea on 04/12/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

extension Meetup {

    @nonobjc public static let domainIdentifier = "ie.mos.tourguide"

    public var userActivityUserInfo: [NSObject: AnyObject]? {
        return userInfo()
    }

    public var userActivity: NSUserActivity? {
        let activity = NSUserActivity(activityType: Meetup.domainIdentifier)
        activity.title = name
        activity.userInfo = userActivityUserInfo
        if let keywords = keywords() {
            activity.keywords = keywords
        }
        activity.contentAttributeSet = attributeSet
        if let date = date {
            activity.expirationDate = date.dateByAddingTimeInterval(24*60*60)
        }
        return activity
    }

    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(
            itemContentType: kUTTypeText as String)
        attributeSet.title = name
        if let dateString = dateString, meetupDescription = meetupDescription {
            attributeSet.contentDescription = "\(dateString) \n\(meetupDescription)"
        }
        attributeSet.relatedUniqueIdentifier = nil
        return attributeSet
    }

    private func keywords() -> Set<String>? {

        let array = name?.componentsSeparatedByCharactersInSet(NSCharacterSet.init(charactersInString: " ! -"))
        guard let keywords = array else {return nil}
        let set = NSSet.init(array: keywords) as! Set<String>
        return set
    }

    private func userInfo() -> [NSObject: AnyObject]? {
        guard let id = id, link = link, name = name, meetupDescription = meetupDescription, date = date, dateString = dateString else {return nil}

        return ["id": id,
                "link": link,
                "name": name,
                "meetupDescription": meetupDescription,
                "date":date,
                "dateString":dateString]
        
    }
    
}