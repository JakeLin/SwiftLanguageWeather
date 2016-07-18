//
//  Created by Tran Xuan Hoang on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftWeather

class TemperatureSpec: QuickSpec {

  override func spec() {

    describe("#init(country:openWeatherMapDegrees:)") {
      context("country is US") {
        it("should convert temperature to Fahrenheit") {
          let temperature = Temperature(country: "US", openWeatherMapDegrees: 20)
          expect(temperature.degrees).to(equal("-424.0" + "\u{f045}"))
        }
      }
      context("country is not US") {
        it("should convert to Celsius") {
          let temperature = Temperature(country: "ABC", openWeatherMapDegrees: 20)
          expect(temperature.degrees).to(equal("-253.0" + "\u{f03c}"))
        }
      }
    }

  }

}
