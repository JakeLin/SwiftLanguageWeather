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
  let temperature: String
  let forecasts: [Forecast]
  
  init(weather: Weather, forecasts: [Forecast]) {
    location = weather.location
    iconText = weather.iconText
    temperature = weather.temperature

    self.forecasts = forecasts
  }
}
