//
//  WeatherService.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

protocol WeatherServiceProtocol : NSObject {
  func retrieveWeatherInfo(location: CLLocation) -> Weather
}
