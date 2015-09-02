//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

class OpenWeatherMapService : WeatherServiceProtocol {
  func retrieveWeatherInfo(location: CLLocation) -> Weather {
    let forecasts = [
        Forecast(time: "10:00", iconText: "", temperature: "10"),
        Forecast(time: "12:00", iconText: "", temperature: "8"),
        Forecast(time: "16:00", iconText: "", temperature: "12"),
        Forecast(time: "20:00", iconText: "", temperature: "14"),
    ]
    let weather = Weather(location: "Sydney", iconText: "", temperature: "10", forecasts: forecasts)
    return weather
  }
}
