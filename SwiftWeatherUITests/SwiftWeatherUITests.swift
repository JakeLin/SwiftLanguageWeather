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
            context("location service is enabled") {
                context("when in portrait") {
                    beforeEach {
                        XCUIDevice.shared.orientation = .portrait
                    }
                    itBehavesLike("a properly laidout wheather viewcontroller")
                }

                context("when in landscape") {
                    beforeEach {
                        XCUIDevice.shared.orientation = .landscapeLeft
                    }
                    itBehavesLike("a properly laidout wheather viewcontroller")
                }
            }
        }
    }
}

class RegularWheatherViewControllerConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        let app = XCUIApplication()
        let window = app.windows.element(boundBy: 0)

        sharedExamples("a properly laidout wheather viewcontroller") { (context: SharedExampleContext) in
            it("shows city") {
                let cityLabel = app.staticTexts["a11y_current_city"]

                expect(cityLabel.exists).to(beTruthy())
                expect(window.frame.contains(cityLabel.frame)).to(beTruthy())
            }

            it("shows wheather icon") {
                let wheatherIconLabel = app.staticTexts["a11y_wheather_icon"]

                expect(wheatherIconLabel.exists).to(beTruthy())
                expect(window.frame.contains(wheatherIconLabel.frame)).to(beTruthy())
            }

            it("shows wheather temperature") {
                let wheatherTemperatureLabel = app.staticTexts["a11y_wheather_temperature"]

                expect(wheatherTemperatureLabel.exists).to(beTruthy())
                expect(window.frame.contains(wheatherTemperatureLabel.frame)).to(beTruthy())
            }
        }
    }
}

