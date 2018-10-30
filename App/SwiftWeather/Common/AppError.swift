//
//  AppError.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation

enum AppError: Error {
    case urlError
    case networkRequestFailed
    case jsonParsingFailed
    case unableToFindLocation
}
