//
//  WeatherViewController.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var iconLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet var forecastViews: [ForecastView]!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = WeatherViewModel()
    viewModel?.startLocationService()
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
