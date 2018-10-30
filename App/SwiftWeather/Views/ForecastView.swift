//
//  ForecastView.swift
//  SwiftWeather
//
//  Created by Jake Lin on 24/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable class ForecastView: UIView {
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadViewFromNib()
        self.timeLabel.text = ""
        self.iconLabel.text = ""
        self.temperatureLabel.text = ""
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        guard let view = loadFromNib() else { return }
        addSubview(view)
    }
    
    // MARK: - ViewModel
    var viewModel: ForecastViewModel = ForecastViewModel() {
        didSet {
            viewModel.time.observe {
                [unowned self] in
                self.timeLabel.text = $0
            }
            
            viewModel.iconText.observe {
                [unowned self] in
                self.iconLabel.text = $0
            }
            
            viewModel.temperature.observe {
                [unowned self] in
                self.temperatureLabel.text = $0
            }
        }
    }
    
    func load(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
}
