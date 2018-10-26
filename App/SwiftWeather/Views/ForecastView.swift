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
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        guard let view = loadFromNib() else { return }
        addSubview(view)
    }
}
