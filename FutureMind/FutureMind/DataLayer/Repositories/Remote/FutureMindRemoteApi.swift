//
//  FutureMindRemoteApi.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 10/04/2022.
//

import Foundation
import Combine

protocol FutureMindRemoteApi {
    var list: CurrentValueSubject<[FutureMind], RemoteApiError> { get }
    func loadList()

}

class FutureMindRemoteApiImpl: FutureMindRemoteApi {

    var list: CurrentValueSubject<[FutureMind], RemoteApiError> = CurrentValueSubject([])

    private let endpoint = URL(string: "https://recruitment-task.futuremind.dev/recruitment-task")
    private let decoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadList()
    }

    func loadList() {
        debugInfo("Load List ")
       URLSession.shared.dataTaskPublisher(for: endpoint!)
            .retry(3)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    debugError("Bad http response \(response)")
                    throw RemoteApiError.badHTTPResponse
                }
                debugSuccess("Received data \(data.description)")
                return data
            }
            .decode(type: [FutureMindResponse].self, decoder: decoder)
            .mapError { error -> Never in
                fatalError()
//                if let error = error as? RemoteApiError {
//                    return error
//                } else {
//                    return RemoteApiError.decoding
//                }
            }
            .flatMap({ futureMindsResponse -> AnyPublisher<[FutureMind], Never> in
                return futureMindsResponse.publisher.map { futureMindResponse -> FutureMind in
                    debugInfo("Mapping futureMindResponser to future mind")
                    return FutureMind(futureMindResponse: futureMindResponse)
                }
                .mapError({ _ -> Never  in })
                .collect()
                .eraseToAnyPublisher()
            })
            .sink( receiveValue: { [weak self] in self?.list.send($0) })
            .store(in: &cancellables)

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
