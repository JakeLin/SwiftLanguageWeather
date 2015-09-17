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
  
  // MARK: - Properties
  let hasError: Observable<Bool>
  let errorMessage: Observable<String?>
  
  let location: Observable<String>
  let iconText: Observable<String>
  let temperature: Observable<String>
  let forecasts: Observable<[ForecastViewModel]>
  
  // MARK: - Services
  private var locationService: LocationService!
  private var weatherService: WeatherServiceProtocol!
  
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
    dispatch_async(dispatch_get_main_queue(), {
      self.hasError.value = false
      self.errorMessage.value = nil
      
      self.location.value = weather.location
      self.iconText.value = weather.iconText
      self.temperature.value = weather.temperature
      
      let tempForecasts = weather.forecasts.map { forecast in
        return ForecastViewModel(forecast)
      }
      self.forecasts.value = tempForecasts
    })
  }
  
  private func update(error: Error) {
    dispatch_async(dispatch_get_main_queue(), {
      self.hasError.value = true
      
      switch error.errorCode {
      case .URLError:
        self.errorMessage.value = "The weather service is not working."
      case .NetworkRequestFailed:
        self.errorMessage.value = "The network appears to be down."
      case .JSONSerializationFailed:
        self.errorMessage.value = "We're having trouble processing weather data."
      case .JSONParsingFailed:
        self.errorMessage.value = "We're having trouble parsing weather data."
      }
      
      self.location.value = self.EmptyString
      self.iconText.value = self.EmptyString
      self.temperature.value = self.EmptyString
      self.forecasts.value = []
    })
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
