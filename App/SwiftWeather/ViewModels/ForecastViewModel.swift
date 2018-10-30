//
//  ForecastViewModel.swift
//  SwiftWeather
//
//  Created by Jake Lin on 23/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    let time: LiveData<String>
    let iconText: LiveData<String>
    let temperature: LiveData<String>

    init() {
        time = LiveData("")
        iconText = LiveData("")
        temperature = LiveData("")
    }

    init(forecast: Forecast) {
        time = LiveData(forecast.time)
        iconText = LiveData(forecast.iconText)
        temperature = LiveData(forecast.temperature)
    }
}
