//
//  Created by Tran Xuan Hoang on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftWeather

class WeatherIconSpec: QuickSpec {

  let dayDictionary = [
    200: "\u{f010}",
    201: "\u{f010}",
    202: "\u{f010}",
    210: "\u{f005}",
    211: "\u{f005}",
    212: "\u{f005}",
    221: "\u{f005}",
    230: "\u{f010}",
    231: "\u{f010}",
    232: "\u{f010}",
    300: "\u{f00b}",
    301: "\u{f00b}",
    302: "\u{f008}",
    310: "\u{f008}",
    311: "\u{f008}",
    312: "\u{f008}",
    313: "\u{f008}",
    314: "\u{f008}",
    321: "\u{f00b}",
    500: "\u{f00b}",
    501: "\u{f008}",
    502: "\u{f008}",
    503: "\u{f008}",
    504: "\u{f008}",
    511: "\u{f006}",
    520: "\u{f009}",
    521: "\u{f009}",
    522: "\u{f009}",
    531: "\u{f00e}",
    600: "\u{f00a}",
    601: "\u{f0b2}",
    602: "\u{f00a}",
    611: "\u{f006}",
    612: "\u{f006}",
    615: "\u{f006}",
    616: "\u{f006}",
    620: "\u{f006}",
    621: "\u{f00a}",
    622: "\u{f00a}",
    701: "\u{f009}",
    711: "\u{f062}",
    721: "\u{f0b6}",
    731: "\u{f063}",
    741: "\u{f003}",
    761: "\u{f063}",
    762: "\u{f063}",
    781: "\u{f056}",
    800: "\u{f00d}",
    801: "\u{f000}",
    802: "\u{f000}",
    803: "\u{f000}",
    804: "\u{f00c}",
    900: "\u{f056}",
    902: "\u{f073}",
    903: "\u{f076}",
    904: "\u{f072}",
    906: "\u{f004}",
    957: "\u{f050}"
  ]
  let nightDictionary = [
    200: "\u{f02d}",
    201: "\u{f02d}",
    202: "\u{f02d}",
    210: "\u{f025}",
    211: "\u{f025}",
    212: "\u{f025}",
    221: "\u{f025}",
    230: "\u{f02d}",
    231: "\u{f02d}",
    232: "\u{f02d}",
    300: "\u{f02b}",
    301: "\u{f02b}",
    302: "\u{f028}",
    310: "\u{f028}",
    311: "\u{f028}",
    312: "\u{f028}",
    313: "\u{f028}",
    314: "\u{f028}",
    321: "\u{f02b}",
    500: "\u{f02b}",
    501: "\u{f028}",
    502: "\u{f028}",
    503: "\u{f028}",
    504: "\u{f028}",
    511: "\u{f026}",
    520: "\u{f029}",
    521: "\u{f029}",
    522: "\u{f029}",
    531: "\u{f02c}",
    600: "\u{f02a}",
    601: "\u{f0b4}",
    602: "\u{f02a}",
    611: "\u{f026}",
    612: "\u{f026}",
    615: "\u{f026}",
    616: "\u{f026}",
    620: "\u{f026}",
    621: "\u{f02a}",
    622: "\u{f02a}",
    701: "\u{f029}",
    711: "\u{f062}",
    721: "\u{f0b6}",
    731: "\u{f063}",
    741: "\u{f04a}",
    761: "\u{f063}",
    762: "\u{f063}",
    781: "\u{f056}",
    800: "\u{f02e}",
    801: "\u{f022}",
    802: "\u{f022}",
    803: "\u{f022}",
    804: "\u{f086}",
    900: "\u{f056}",
    902: "\u{f073}",
    903: "\u{f076}",
    904: "\u{f072}",
    906: "\u{f024}",
    957: "\u{f050}"
  ]

  override func spec() {

    describe("#init(condition:,iconString:)") {
      context("day") {
        context("invalid condition Int") {
          self.expectWeatherIconWithCondition(999, isDay: true, toHaveIconTextEqualToString: "")
        }
        context("valid condition Int") {
          for (condition, description) in self.dayDictionary {
            self.expectWeatherIconWithCondition(condition, isDay: true,
              toHaveIconTextEqualToString: description)
          }
        }
      }
      context("night") {
        context("invalid condition Int") {
          self.expectWeatherIconWithCondition(999, isDay: false, toHaveIconTextEqualToString: "")
        }
        context("valid condition Int") {
          for (condition, description) in self.nightDictionary {
            self.expectWeatherIconWithCondition(condition, isDay: false,
              toHaveIconTextEqualToString: description)
          }
        }
      }
    }

  }

}

extension WeatherIconSpec {

  func expectWeatherIconWithCondition(_ condition: Int, isDay: Bool,
      toHaveIconTextEqualToString description: String) {
    let weatherIcon = WeatherIcon(condition: condition, iconString: isDay ? "day" : "night")
    expect(weatherIcon.iconText).to(equal(description))
  }

}
