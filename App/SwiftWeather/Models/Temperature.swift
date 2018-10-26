//
//  Temperature.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//


import Foundation

struct Temperature {
    let degrees: String
    
    init(country: String, openWeatherMapDegrees: Double) {
        if country == "US" {
            degrees = String(TemperatureConverter.kelvinToFahrenheit(openWeatherMapDegrees)) + "\u{f045}"
        } else {
            degrees = String(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees)) + "\u{f03c}"
        }
    }
}
