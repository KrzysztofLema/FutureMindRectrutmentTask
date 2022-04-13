//
//  MockFutureMindResponse.swift
//  FutureMindTests
//
//  Created by Krzysztof Lema on 12/04/2022.
//

import Foundation
import Combine
@testable import FutureMind
extension FutureMindResponse{
    static func mock() -> FutureMindResponse {
        FutureMindResponse(description: "", imageUrl: "", modificationDate: "", orderId: 1, title: "")
    }

    static func mock(with orderID: Int) -> FutureMindResponse {
        FutureMindResponse(description: "", imageUrl: "", modificationDate: "", orderId: orderID, title: "")
    }
}

class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var statusCode: Int?
    static func mockResponse(url: URL, statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        self.client?.urlProtocol(
            self,
            didReceive: MockURLProtocol.mockResponse(
                url:request.url!,
                statusCode: MockURLProtocol.statusCode!)!,
            cacheStoragePolicy: .notAllowed
        )
        self.client?.urlProtocol(
            self,
            didLoad: MockURLProtocol.testData ?? Data()
        )

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

class MockFutureMindRemoteApiImpl: FutureMindRemoteApi {

    let futureMindResponse: [FutureMindResponse]
    let error: Error?

    init(futureMindResponse: [FutureMindResponse], error: Error? = nil) {
      self.futureMindResponse = futureMindResponse
      self.error = error
    }

    func loadList() -> AnyPublisher<[FutureMindResponse], Error> {
      let publisher = PassthroughSubject<[FutureMindResponse], Error>()

      DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
          if let error = self.error {
            publisher.send(completion: .failure(error))
        } else {
            publisher.send(self.futureMindResponse)
        }
      }
      return publisher.eraseToAnyPublisher()
    }
}
