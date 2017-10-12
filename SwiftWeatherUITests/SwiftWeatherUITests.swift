//
//  Created by Jake Lin on 8/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import XCTest
import Quick
import Nimble

class SwiftWeatherUITests: QuickSpec {

    override func spec() {
        let app = XCUIApplication()

        beforeSuite {
            self.continueAfterFailure = false
            XCUIDevice.shared().orientation = .portrait
            app.launch()
        }

        describe("a wheather viewcontroller") {
            it("shows city") {
                expect(app.staticTexts["a11y_current_city"].exists).to(beTruthy())
            }

            it("shows wheather icon") {
                expect(app.staticTexts["a11y_wheather_icon"].exists).to(beTruthy())
            }

            it("shows wheather temperature") {
                expect(app.staticTexts["a11y_wheather_temperature"].exists).to(beTruthy())
            }
        }
    }

}
