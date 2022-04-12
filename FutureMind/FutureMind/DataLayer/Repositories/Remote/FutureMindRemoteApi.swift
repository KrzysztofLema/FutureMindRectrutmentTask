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
    
    private let endpoint = URL(string: "https://recruitment-task.futuremind.dev/recruitment-task")
    private let decoder = JSONDecoder()
    
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    
    func loadList() -> AnyPublisher<[FutureMindResponse], Error> {
        URLSession.shared.dataTaskPublisher(for: endpoint!)
            .share()
            .receive(on: apiQueue)
            .map { $0.data }
            .decode(type: [FutureMindResponse].self, decoder: decoder)
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
