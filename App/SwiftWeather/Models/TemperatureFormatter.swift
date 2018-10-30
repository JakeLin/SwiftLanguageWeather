//
//  Temperature.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//


import Foundation

struct TemperatureFormatter {
    static func format(country: String?, openWeatherMapDegrees: Double) -> String {
        guard let country = country else { return "" }
        
        if country == "US" {
            return "\(TemperatureConverter.kelvinToFahrenheit(openWeatherMapDegrees))\u{f045}"
        } else {
            return "\(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees))\u{f03c}"
        }
    }
}
