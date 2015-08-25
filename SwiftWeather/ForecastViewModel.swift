//
//  ForecastViewModel.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

class ForecastViewModel{
  var time: String
  var iconText: String
  var temperature: String
  
  init(forecast: Forecast) {
    time = forecast.time
    iconText = forecast.iconText
    temperature = forecast.temperature
  }
}