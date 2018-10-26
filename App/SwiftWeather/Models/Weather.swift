//
//  File.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation

struct Weather {
    let location: String
    let iconText: String
    let temperature: String
    let forecasts: [Forecast]
}
