//
//  TemperatureConverter.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation

struct TemperatureConverter {
    static func kelvinToCelsius(_ degrees: Double) -> Double {
        return round(degrees - 273.15)
    }
    
    static func kelvinToFahrenheit(_ degrees: Double) -> Double {
        return round(degrees * 9 / 5 - 459.67)
    }
}
