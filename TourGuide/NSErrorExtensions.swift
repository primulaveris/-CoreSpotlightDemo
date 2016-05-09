//
//  NSErrorExtensions.swift
//  TourGuide
//
//  Created by Marian O'Shea on 02/09/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import Foundation

extension NSError {
    
    public enum InfoDataSourceErrorType: Int {
        case InvalidJSON = 9991
        case InvalidURL = 9992
        case Unknown = 9990
    }
    
    convenience init(_ type: InfoDataSourceErrorType, extraInfo: [NSObject: AnyObject]? = nil) {
        self.init(domain: "ie.marianoshea.TourGuide", code: type.rawValue, userInfo: extraInfo)
    }
    
}