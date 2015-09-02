//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

class OpenWeatherMapService : WeatherServiceProtocol {
  func retrieveWeatherInfo(location: CLLocation) -> Weather {
    let weather: Weather = Weather(location: "Sydney", iconText: "", temperature: "10", forecasts: [])
    return weather
  }
}
