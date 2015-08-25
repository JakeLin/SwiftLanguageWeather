//
//  WeatherViewModel.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

class WeatherViewModel {
  var location: String
  var iconText: String
  var temperature: String
  
  init(weather: Weather) {
    location = weather.location
    iconText = weather.iconText
    temperature = weather.temperature
  }
}
