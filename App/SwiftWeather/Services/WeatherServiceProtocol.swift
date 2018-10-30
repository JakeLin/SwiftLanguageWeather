//
//  ViewController.swift
//  SwiftWeather
//
//  Created by Jake Lin on 20/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Weather?, AppError?) -> Void

protocol WeatherServiceProtocol {
    func requestWeather(location: CLLocation, completionHandler: @escaping WeatherCompletionHandler)
}

