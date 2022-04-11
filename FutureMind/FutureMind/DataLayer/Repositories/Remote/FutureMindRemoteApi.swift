//
//  FutureMindRemoteApi.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 10/04/2022.
//

import Foundation
import Combine

protocol FutureMindRemoteApi {
    var list: AnyPublisher<[FutureMind], RemoteApiError>? { get }
    func loadList() -> AnyPublisher<[FutureMind], RemoteApiError>
}

class FutureMindRemoteApiImpl: FutureMindRemoteApi {

    var list: AnyPublisher<[FutureMind], RemoteApiError>?

    private let endpoint = URL(string: "https://recruitment-task.futuremind.dev/recruitment-task")
    private var urlSession = URLSession.shared
    private let decoder = JSONDecoder()

    init() {
        list = loadList()
    }

    func loadList() -> AnyPublisher<[FutureMind], RemoteApiError> {
        debugInfo("Load List ")
        return urlSession.dataTaskPublisher(for: endpoint!)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    debugError("Bad http response \(response)")
                    throw RemoteApiError.badHTTPResponse
                }
                debugSuccess("Received data \(data.description)")
                return data
            }
            .decode(type: [FutureMindResponse].self, decoder: decoder)
            .mapError { error -> RemoteApiError in
                if let error = error as? RemoteApiError {
                    return error
                } else {
                    return RemoteApiError.decoding
                }
            }
            .flatMap({ futureMindsResponse -> AnyPublisher<[FutureMind], RemoteApiError> in
                return futureMindsResponse.publisher.map { futureMindResponse -> FutureMind in
                    debugInfo("Mapping futureMindResponser to future mind")
                    return FutureMind(futureMindResponse: futureMindResponse)
                }
                .mapError({ _ -> RemoteApiError  in })
                .collect()
                .eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
}

enum RemoteApiError: Error {
    case unknown
    case createURL
    case httpError
    case decoding
    case mapError
    case badHTTPResponse
}
