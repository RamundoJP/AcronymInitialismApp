//
//  AcronymAppUITests.swift
//  AcronymAppUITests
//
//  Created by Ramundo, Juan Pablo on 12/09/2021.
//

import XCTest

class AcronymAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchSuccess() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let searchField = app.searchFields.element(boundBy: 0)
        searchField.tap()
        searchField.typeText("http")
        
        app.keyboards.buttons.matching(identifier: "Search").firstMatch.tap()
        app.waitForExistence(timeout: 3)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
