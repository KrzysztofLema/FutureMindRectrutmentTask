//
//  FutureMindRemoteApiTests.swift
//  FutureMindTests
//
//  Created by Krzysztof Lema on 12/04/2022.
//

import XCTest
import Combine
@testable import FutureMind

class FutureMindRemoteApiTests: XCTestCase {

    var sut: FutureMindRemoteApiImpl!
    var session: URLSession!
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        sut = FutureMindRemoteApiImpl(urlSession: session)
    }

    override func tearDown() {
        sut = nil
        session = nil
    }

    func test_whenTheStatusCodeIs200_AfterSendRequest_ShouldReceiveData() {
        //given
        let expectation = XCTestExpectation()
        let expectedValue = [FutureMindResponse.mock()]
        MockURLProtocol.testData = try? JSONEncoder().encode([FutureMindResponse.mock()])
        MockURLProtocol.statusCode = 200
        var receivedValue: [FutureMindResponse]?
        //when
        sut.loadList().sink(receiveCompletion: { _ in }) { received in
            receivedValue = received
            expectation.fulfill()
        }.store(in: &subscriptions)

        //than
        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(expectedValue, receivedValue)
    }

    func test_whenTheStatusCodeIs400_ShouldReceiveBadHTTPResponseError()  {
        //given
        let expectation = XCTestExpectation()
        MockURLProtocol.statusCode = 401
        
        //when
        sut.loadList().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                do {
                    let error = try XCTUnwrap(error as? RemoteApiError)
                    XCTAssertEqual(error, .validationError)
                    expectation.fulfill()
                } catch { XCTFail("") }
            case .finished:
                XCTFail("Expected to succeed but received error")
            }
        }) { _ in }.store(in: &subscriptions)

        //than
        wait(for: [expectation], timeout: 1.0)
    }

    func test_whenTheStatusCodeIs400_ShouldReceiveValidationError()  {
        //given
        let expectation = XCTestExpectation()
        MockURLProtocol.statusCode = 400

        //when
        sut.loadList().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                do {
                    let error = try XCTUnwrap(error as? RemoteApiError)
                    XCTAssertEqual(error, .badHTTPResponse)
                    expectation.fulfill()
                } catch { XCTFail("") }
            case .finished:
                XCTFail("Expected to succeed but received error")
            }
        }) { _ in }.store(in: &subscriptions)

        //than
        wait(for: [expectation], timeout: 1.0)
    }

    func test_whenTheStatusCodeIs200_afterSendRequest_DecodingErrorAppears() {
        //given
        let expectation = XCTestExpectation()
        let expectedValue = [FutureMindResponse.mock()]
        MockURLProtocol.testData = try? JSONEncoder().encode(FutureMindResponse.mock())
        MockURLProtocol.statusCode = 200
        //when
        sut.loadList().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                do {
                    let error = try XCTUnwrap(error as? RemoteApiError)
                    XCTAssertEqual(error, .decoding)
                    expectation.fulfill()
                } catch { XCTFail("") }
            case .finished:
                XCTFail("Expected to succeed but received error")
            }
        }) { _ in }
        .store(in: &subscriptions)

        //than
        wait(for: [expectation], timeout: 1.0)
    }

    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}




