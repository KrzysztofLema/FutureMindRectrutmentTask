//
//  FutureMindUITests.swift
//  FutureMindUITests
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import XCTest
@testable import FutureMind

class ListViewUITests: BaseTestCase {

    func test_whenListViewIsDisplayed() {
        XCTAssertTrue(listScreenIsShowing)
        XCTAssertTrue(tableViewIsShowing)
        XCTAssertTrue(activityIndicatorIsShowing)
    }
}

extension ListViewUITests {
    var listScreenIsShowing: Bool {
        waitForElement(view, willAppear: true, after: 4.0)
    }

    var tableViewIsShowing: Bool {
        tableView.element.exists
    }

    var activityIndicatorIsShowing: Bool {
        activityIndicator.element.exists
    }

    var tableView: XCUIElementQuery {
        view.tables.matching(identifier: ViewsAccessibilityLabels.ListView.tableView)
    }

    var view: XCUIElement {
        application.otherElements[ViewsAccessibilityLabels.ListView.view]
    }
    var activityIndicator: XCUIElementQuery {
        view.activityIndicators.matching(identifier: ViewsAccessibilityLabels.ListView.activityIndicator)
    }
}
