//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
  func retrieveWeatherInfo(location: CLLocation) -> Weather?
}
