//
//  Created by Tran Xuan Hoang on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftWeather

class ForecastDateTimeSpec: QuickSpec {
    
    private let testTimeZone = TimeZone(abbreviation: "UTC+11:00")!
    
    override func spec() {
        describe("#init") {
            it("should init with the rawDate correctly assigned") {
                var forecastDateTime = ForecastDateTime(date: 1488096060, timeZone: self.testTimeZone)
                expect(forecastDateTime.rawDate).to(beCloseTo(1488096060))
                forecastDateTime = ForecastDateTime(date: 0, timeZone: self.testTimeZone)
                expect(forecastDateTime.rawDate).to(beCloseTo(0))
            }
        }
        
        describe("#shortTime") {
            it("should return the correct shortTime string with format HH:mm") {
                var forecastDateTime = ForecastDateTime(date: 1488096060, timeZone: self.testTimeZone)
                expect(forecastDateTime.shortTime).to(equal("7:01 PM"))
                forecastDateTime = ForecastDateTime(date: 1488103200, timeZone: self.testTimeZone)
                expect(forecastDateTime.shortTime).to(equal("9:00 PM"))
            }
        }
    }
}
