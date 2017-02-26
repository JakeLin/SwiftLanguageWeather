//
//  Created by Tran Xuan Hoang on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftWeather

class ForecastDateTimeSpec: QuickSpec {

  override func spec() {

    describe("#init") {
      it("should init with the rawDate correctly assigned") {
        var forecastDateTime = ForecastDateTime(1234)
        expect(forecastDateTime.rawDate).to(beCloseTo(1234))
        forecastDateTime = ForecastDateTime(0)
        expect(forecastDateTime.rawDate).to(beCloseTo(0))
      }
    }

    describe("#shortTime") {
      it("should return the correct shortTime string with format HH:mm") {
        var forecastDateTime = ForecastDateTime(1488096060)
        expect(forecastDateTime.shortTime).to(equal("19:01"))
        forecastDateTime = ForecastDateTime(1488103200)
        expect(forecastDateTime.shortTime).to(equal("21:00"))
      }
    }

  }
}
