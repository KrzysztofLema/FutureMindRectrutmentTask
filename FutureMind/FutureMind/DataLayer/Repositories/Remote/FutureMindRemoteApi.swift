//
//  FutureMindRemoteApi.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 10/04/2022.
//

import Foundation
import Combine

protocol FutureMindRemoteApi {
    func loadList() -> AnyPublisher<[FutureMindResponse], Error>
}

class FutureMindRemoteApiImpl: FutureMindRemoteApi {

    let urlSession: URLSession
    
    private let url = URL(string: "https://recruitment-task.futuremind.dev/recruitment-task")
    private let decoder = JSONDecoder()
    
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func loadList() -> AnyPublisher<[FutureMindResponse], Error> {
        guard let url = url else {
            return Fail(error: RemoteApiError.invalidRequestError)
                .eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: url)
            .mapError({ _ in
                RemoteApiError.connectionFailure
            })
            .receive(on: apiQueue)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw RemoteApiError.badHTTPResponse
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    if httpResponse.statusCode == 401 {
                        throw RemoteApiError.validationError
                    } else {
                        throw RemoteApiError.badHTTPResponse
                    }
                }
                return data
            }.tryMap({ data -> [FutureMindResponse] in
                do {
                    return try self.decoder.decode(
                        [FutureMindResponse].self,
                        from: data)
                }
                catch {
                    throw RemoteApiError.decoding
                }
            })
            .eraseToAnyPublisher()
    }
}

enum RemoteApiError: Error {
    case invalidRequestError
    case connectionFailure
    case httpError
    case decoding
    case badHTTPResponse
    case validationError

    var errorDescription: String {
        switch self {
        case .invalidRequestError:
           return "Invalid request error"
        case .connectionFailure:
            return "Connection Failure"
        case .httpError:
            return "There is some http error."
        case .decoding:
            return "Server returned data in unexpected format."
        case .badHTTPResponse:
            return "There is problem with http response"
        case .validationError:
            return "Validation Error"
        }
    }
}
