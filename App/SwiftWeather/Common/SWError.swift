//
//  SWError.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation

enum SWError: Error {
    case urlError
    case networkRequestFailed
    case jsonSerializationFailed
    case jsonParsingFailed
    case unableToFindLocation
}
