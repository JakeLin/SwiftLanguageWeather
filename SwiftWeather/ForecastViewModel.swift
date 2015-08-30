//
//  ForecastViewModel.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

class ForecastViewModel{
  let time: String
  let iconText: String
  let temperature: String
  
  init(_ forecast: Forecast) {
    time = forecast.time
    iconText = forecast.iconText
    temperature = forecast.temperature
  }
}
