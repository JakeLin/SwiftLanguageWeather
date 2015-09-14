//
//  WeatherViewModel.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel {
  // MARK: - Constants
  private let EmptyString = ""
  
  // MARK: - Services
  private var locationService: LocationService!
  private var weatherService: WeatherServiceProtocol!
  
  // MARK: - Properties
  var hasError: Observable<Bool>
  var errorMessage: Observable<String?>
  
  var location: Observable<String>
  var iconText: Observable<String>
  var temperature: Observable<String>
  var forecasts: Observable<[ForecastViewModel]>
  
  // MARK: - init
  init() {
    hasError = Observable(false)
    errorMessage = Observable(nil)
    
    location = Observable(EmptyString)
    iconText = Observable(EmptyString)
    temperature = Observable(EmptyString)
    forecasts = Observable([])
  }
  
  // MARK: - public
  func startLocationService() -> Void {
    locationService = LocationService()
    locationService.delegate = self
    
    weatherService = OpenWeatherMapService()
    
    locationService.requestLocation()
  }
  
  // MARK: - private
  private func update(weather: Weather) {
    hasError = Observable(false)
    errorMessage = Observable(nil)
    
    location = Observable(weather.location)
    iconText = Observable(weather.iconText)
    temperature = Observable(weather.temperature)

    let tempForecasts = weather.forecasts.map { forecast in
      return ForecastViewModel(forecast)
    }
    forecasts = Observable(tempForecasts)
  }
  
  private func update(error: Error) {
    hasError = Observable(true)
    
    switch error.errorCode {
    case .URLError:
      errorMessage = Observable("The weather service is not working.")
    case .NetworkRequestFailed:
      errorMessage = Observable("The network appears to be down.")
    case .JSONSerializationFailed:
      errorMessage = Observable("We're having trouble processing weather data.")
    case .JSONParsingFailed:
      errorMessage = Observable("We're having trouble parsing weather data.")
    }
    
    location = Observable(EmptyString)
    iconText = Observable(EmptyString)
    temperature = Observable(EmptyString)
    forecasts = Observable([])
  }
}

// MARK: LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
  func locationDidUpdate(service: LocationService, location: CLLocation) {
    weatherService.retrieveWeatherInfo(location) { (weather, error) -> Void in
      if let unwrappedError = error {
        print(unwrappedError)
        self.update(unwrappedError)
        return
      }
      
      guard let unwrappedWeather = weather else {
        return
      }
      self.update(unwrappedWeather)
    }
  }
}
