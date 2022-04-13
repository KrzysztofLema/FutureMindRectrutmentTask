//
//  ListViewModelsTests.swift
//  FutureMindTests
//
//  Created by Krzysztof Lema on 13/04/2022.
//

import XCTest
import Combine
@testable import FutureMind

class ListViewModelsTests: XCTestCase {

    var sut: ListViewModel!
    var mockFutureMindRemoteApi: FutureMindRemoteApi!
    private var subscriptions = Set<AnyCancellable>()

    override func tearDown() {
        sut = nil
        mockFutureMindRemoteApi = nil
        subscriptions = []
    }

    func test_loadFutureMindsSuccess() {
        //given
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock()], error: nil)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: [FutureMind]?

        sut.allFutureMinds.sink { _ in } receiveValue: { futureMind in
            expectedValue = futureMind
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.fetchFutureMinds()

        wait(for: [expectation], timeout: 1.0)
        XCTAssert([FutureMind(futureMindResponse: .mock())] == expectedValue)
    }

    func test_loadFutureMindsInRightOrder() {
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock(with: 2),.mock(with: 1),.mock(with: 0)], error: nil)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: [FutureMind]?

        sut.allFutureMinds.sink { _ in } receiveValue: { futureMind in
            expectedValue = futureMind
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.fetchFutureMinds()

        wait(for: [expectation], timeout: 1.0)
        XCTAssert([FutureMind(futureMindResponse: .mock(with: 0)), FutureMind(futureMindResponse: .mock(with: 1)), FutureMind(futureMindResponse: .mock(with: 2))] == expectedValue)
    }

    func test_loadFutureMindsSuccessAfterPullToRefresh() {
        //given
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock()], error: nil)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: [FutureMind]?

        sut.allFutureMinds.sink { _ in } receiveValue: { futureMind in
            expectedValue = futureMind
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.pullToRefresh()

        wait(for: [expectation], timeout: 1.0)
        XCTAssert([FutureMind(futureMindResponse: .mock())] == expectedValue)
    }

    func test_loadFutureMindsFailureWithDecodingError() {
        //given
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock()], error: RemoteApiError.decoding)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: RemoteApiError?

        sut.allFutureMindsError.sink { error in
            expectedValue = error
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.pullToRefresh()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expectedValue, RemoteApiError.decoding)
    }

    func test_loadFutureMindsFailureWithBadHTTPReponse() {
        //given
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock()], error: RemoteApiError.badHTTPResponse)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: RemoteApiError?
        //when
        sut.allFutureMindsError.sink { error in
            expectedValue = error
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.pullToRefresh()
        //then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expectedValue, RemoteApiError.badHTTPResponse)
    }

    func test_loadFutureMindsFailureWithInvalidRequest() {
        //given
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock()], error: RemoteApiError.invalidRequestError)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: RemoteApiError?
        //when
        sut.allFutureMindsError.sink { error in
            expectedValue = error
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.pullToRefresh()
        //then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expectedValue, RemoteApiError.invalidRequestError)
    }

    func test_loadFutureMindsFailureWithConnectionFailure() {
        //given
        let expectation = XCTestExpectation()
        mockFutureMindRemoteApi = MockFutureMindRemoteApiImpl(futureMindResponse: [.mock()], error: RemoteApiError.connectionFailure)
        sut = ListViewModel(futureMindRemoteApi: mockFutureMindRemoteApi)
        var expectedValue: RemoteApiError?
        //when
        sut.allFutureMindsError.sink { error in
            expectedValue = error
            expectation.fulfill()
        }.store(in: &subscriptions)

        sut.pullToRefresh()
        //then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expectedValue, RemoteApiError.connectionFailure)
    }
}
