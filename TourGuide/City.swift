//
//  City.swift
//
//  Created by Marian OShea on 30/11/2015.
//  Copyright © 2015 Marian O’Shea. All rights reserved.
//

import UIKit
import CoreLocation

public final class City: NSObject {
    var name: String?
    var location: CLLocation?
    
    
    init(name: String, location:CLLocation) {
        self.name = name
        self.location = location
    }
}