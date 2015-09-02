//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

struct OpenWeatherMapService : WeatherServiceProtocol {
  let url = "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}"
  
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
