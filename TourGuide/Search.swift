//
//  Search.swift
//  MeetupDemo
//
//  Created by Marian OShea on 06/05/2016.
//  Copyright © 2016 Marian O'Shea. All rights reserved.
//

import Foundation
import CoreLocation

public struct Search {
    public let coordinates: CLLocationCoordinate2D
    public let checkinDate: NSDate
    public let lengthOfStay: Int
}
