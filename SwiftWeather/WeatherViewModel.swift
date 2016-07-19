//
//  Created by Jake Lin on 8/26/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel {
  // MARK: - Constants
  private let emptyString = ""

  // MARK: - Properties
  let hasError: Observable<Bool>
  let errorMessage: Observable<String?>

  let location: Observable<String>
  let iconText: Observable<String>
  let temperature: Observable<String>
  let forecasts: Observable<[ForecastViewModel]>

  // MARK: - Services
  private var locationService: LocationService
  private var weatherService: WeatherServiceProtocol

  // MARK: - init
  init() {
    hasError = Observable(false)
    errorMessage = Observable(nil)

    location = Observable(emptyString)
    iconText = Observable(emptyString)
    temperature = Observable(emptyString)
    forecasts = Observable([])

    // Can put Dependency Injection here
    locationService = LocationService()
    weatherService = OpenWeatherMapService()
  }

  // MARK: - public
  func startLocationService() {
    locationService.delegate = self
    locationService.requestLocation()
  }

  // MARK: - private
  private func update(weather: Weather) {
      hasError.value = false
      errorMessage.value = nil

      location.value = weather.location
      iconText.value = weather.iconText
      temperature.value = weather.temperature

      let tempForecasts = weather.forecasts.map { forecast in
        return ForecastViewModel(forecast)
      }
      forecasts.value = tempForecasts
  }

  private func update(error: Error) {
      hasError.value = true

      switch error.errorCode {
      case .URLError:
        errorMessage.value = "The weather service is not working."
      case .NetworkRequestFailed:
        errorMessage.value = "The network appears to be down."
      case .JSONSerializationFailed:
        errorMessage.value = "We're having trouble processing weather data."
      case .JSONParsingFailed:
        errorMessage.value = "We're having trouble parsing weather data."
      }

      location.value = emptyString
      iconText.value = emptyString
      temperature.value = emptyString
      self.forecasts.value = []
  }
}

// MARK: LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
  func locationDidUpdate(service: LocationService, location: CLLocation) {
    weatherService.retrieveWeatherInfo(location) { (weather, error) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        if let unwrappedError = error {
          print(unwrappedError)
          self.update(unwrappedError)
          return
        }

        guard let unwrappedWeather = weather else {
          return
        }
        self.update(unwrappedWeather)
      })
    }
  }
}
