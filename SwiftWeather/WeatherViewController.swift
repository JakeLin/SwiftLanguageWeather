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

  // MARK: ViewModel
  var viewModel: WeatherViewModel? {
    didSet {
      viewModel?.location.observe {
        [unowned self] in
        self.locationLabel.text = $0
      }

      viewModel?.iconText.observe {
        [unowned self] in
        self.iconLabel.text = $0
      }

      viewModel?.temperature.observe {
        [unowned self] in
        self.temperatureLabel.text = $0
      }

      viewModel?.forecasts.observe {
        [unowned self] (forecastViewModels) in
        if forecastViewModels.count >= 4 {
          for (index, forecastView) in self.forecastViews.enumerated() {
            forecastView.loadViewModel(forecastViewModels[index])
          }
        }
      }
    }
  }
}
