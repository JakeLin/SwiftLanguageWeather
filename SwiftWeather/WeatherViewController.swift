//
//  WeatherViewController.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var iconLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet var forecastViews: [ForecastView]!

  private var weatherService: WeatherServiceProtocol!
  private var locationService: LocationService!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationService = LocationService()
    locationService.delegate = self
    
    weatherService = OpenWeatherMapService()
    
    locationService.requestLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: ViewModel
  var viewModel: WeatherViewModel? {
    didSet {
      viewModel?.location.observe {
        [unowned self] in
        let temp = $0
        dispatch_async(dispatch_get_main_queue(), {
          self.locationLabel.text = temp
        })
      }

      viewModel?.iconText.observe {
        [unowned self] in
        let temp = $0
        dispatch_async(dispatch_get_main_queue(), {
          self.iconLabel.text = temp
        })
      }

      viewModel?.temperature.observe {
        [unowned self] in
        let temp = $0
        dispatch_async(dispatch_get_main_queue(), {
          self.temperatureLabel.text = temp
        })
      }

      viewModel?.forecasts.observe {
        [unowned self] (let forecastViewModels) in
        if forecastViewModels.count >= 4 {
          for (index, forecastView) in self.forecastViews.enumerate() {
            forecastView.loadViewModel(forecastViewModels[index])
          }
        }
      }
    }
  }
}

// MARK: LocationServiceDelegate
extension WeatherViewController: LocationServiceDelegate {
  func locationDidUpdate(service: LocationService, location: CLLocation) {
    weatherService.retrieveWeatherInfo(location) { (weather, error) -> Void in
      if let unwrappedError = error {
        print(unwrappedError)
        self.viewModel = WeatherViewModel(unwrappedError)
        return
      }
      
      guard let unwrappedWeather = weather else {
        return
      }
      self.viewModel = WeatherViewModel(unwrappedWeather)
    }
  }
}
