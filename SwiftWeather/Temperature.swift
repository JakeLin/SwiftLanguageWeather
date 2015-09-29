//
//  Temperature.swift
//  SwiftWeather
//
//  Created by Jake Lin on 9/9/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

struct Temperature {
  let degrees: String
  
  init(country: String, openWeatherMapDegrees: Double) {
    if country == "US" {
      // Convert temperature to Fahrenheit if user is within the US
      degrees = String(round(((openWeatherMapDegrees - 273.15) * 1.8) + 32)) + "\u{f045}"
    }
    else {
      // Otherwise, convert temperature to Celsius
      degrees = String(round(openWeatherMapDegrees - 273.15)) + "\u{f03c}"
    }
  }
}
