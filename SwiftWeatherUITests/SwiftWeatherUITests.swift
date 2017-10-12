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

            app.launch()
        }

        describe("a wheather viewcontroller") {
            context("when the app orientation is portrait") {
                beforeEach {
                    XCUIDevice.shared().orientation = .portrait
                }
                itBehavesLike("a regular wheather viewcontroller")
            }

            context("when the app orientation is landscape") {
                beforeEach {
                    XCUIDevice.shared().orientation = .landscapeLeft
                }
                itBehavesLike("a regular wheather viewcontroller")
            }
        }
    }
}

class RegularWheatherViewControllerConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        let app = XCUIApplication()

        sharedExamples("a regular wheather viewcontroller") { (context: SharedExampleContext) in
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

