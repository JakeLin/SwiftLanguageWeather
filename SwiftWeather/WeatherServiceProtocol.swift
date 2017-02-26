//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Weather?, SWError?) -> Void

protocol WeatherServiceProtocol {
  func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler)
}
