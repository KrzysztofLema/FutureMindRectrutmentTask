//
//  FutureMindUITestsLaunchTests.swift
//  FutureMindUITests
//
//  Created by Krzysztof Lema on 07/04/2022.
//
import XCTest

class BaseTestCase: XCTestCase {
    var application: XCUIApplication!

    override func setUp() {
        super.setUp()
        launchApplication()
    }

    func waitForElement(_ element: XCUIElement, willAppear: Bool = true, after timeout: Double = 4.0) -> Bool {
        let predicate = NSPredicate(format: "%K == %d", #keyPath(XCUIElement.exists), willAppear)
        let expectationToFulfill = expectation(for: predicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [expectationToFulfill], timeout: timeout)
        return result == .completed
    }
}

private extension BaseTestCase {
    func launchApplication() {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }
}
