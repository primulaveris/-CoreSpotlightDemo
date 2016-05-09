//
//  CitySearch.swift
//  MeetupDemo
//
//  Created by Marian OShea on 07/12/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

extension City {
    @nonobjc public static let domainIdentifier = "ie.mos.tourguide.city"
    
    public var userActivityUserInfo: [NSObject: AnyObject]? {
        return ["id": name!, "location": location!]
    }

    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = name
        attributeSet.contentDescription = "Find Meetups in \(name!)"
        attributeSet.relatedUniqueIdentifier = name
        attributeSet.keywords = [name!]
        return attributeSet
    }
    
    var searchableItem: CSSearchableItem {
        let item = CSSearchableItem(uniqueIdentifier: name,
            domainIdentifier: City.domainIdentifier,
            attributeSet: attributeSet)
        return item
    }
}