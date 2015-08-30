//
//  WeatherViewModel.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

class WeatherViewModel {
  let location: String
  let iconText: String
  let temperature: String // https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-XID_314
  let forecasts: [Forecast]
  
  init(_ weather: Weather) {
    location = weather.location
    iconText = weather.iconText
    temperature = weather.temperature

    self.forecasts = weather.forecasts
  }
}
