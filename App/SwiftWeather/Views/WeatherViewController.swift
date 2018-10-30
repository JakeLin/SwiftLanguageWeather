//
//  WeatherViewController.swift
//  SwiftWeather
//
//  Created by Jake Lin on 27/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var iconLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private var forecastViews: [ForecastView]!
    
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        viewModel.startLocationService()
    }
}

private extension WeatherViewController {
    func setupBindings() {
        viewModel.location.observe { [unowned self] in
            self.locationLabel.text = $0
        }
        viewModel.iconText.observe { [unowned self] in
            self.iconLabel.text = $0
        }
        viewModel.temperature.observe { [unowned self] in
            self.temperatureLabel.text = $0
        }
        viewModel.message.observe { [unowned self] in
            self.messageLabel.text = $0
        }
        
        viewModel.forecasts.observe { [unowned self] in
            if $0.count >= 4 {
                for (index, forecastView) in self.forecastViews.enumerated() {
                    forecastView.load(viewModel: $0[index])
                }
            }
        }
    }
}
