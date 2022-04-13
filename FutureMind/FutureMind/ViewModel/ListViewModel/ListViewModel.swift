//
//  ViewControllerViewModel.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import Combine
import Foundation

public class ListViewModel {

    var allFutureMinds = PassthroughSubject<[FutureMind], Error>()
    var allFutureMindsError = PassthroughSubject<RemoteApiError, Never>()
    var futureMinds = [FutureMind]()

    private var subscriptions = Set<AnyCancellable>()
    private var futureMindRemoteApi: FutureMindRemoteApi

    init(futureMindRemoteApi: FutureMindRemoteApi) {
        self.futureMindRemoteApi = futureMindRemoteApi
        fetchFutureMinds()
    }

    @objc func pullToRefresh() {
        fetchFutureMinds()
    }

    func fetchFutureMinds() {
        futureMindRemoteApi.loadList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.handleFutureMindError(error)
                }
            }, receiveValue: { [weak self] futureMindsResponse in
                guard let self = self else {
                    return
                }
                let futureMinds = self.mapFutureMinds(futureMindsResponse)
                self.futureMinds = futureMinds
                self.allFutureMinds.send(futureMinds)
            })
            .store(in: &subscriptions)
    }
}

private extension ListViewModel {
    func mapFutureMinds(_ futureMindsResponse: [FutureMindResponse]) -> [FutureMind] {
        futureMindsResponse
            .sorted(by: {
                $0.orderId < $1.orderId
            })
            .map { futureMindResponse in
                FutureMind(futureMindResponse: futureMindResponse)
            }
    }

    func handleFutureMindError(_ error: Error) {
        guard let error = error as? RemoteApiError else {
            return
        }
        switch error {
        case .invalidRequestError:
            self.allFutureMindsError.send(.invalidRequestError)
        case .connectionFailure:
            self.allFutureMindsError.send(.connectionFailure)
        case .httpError:
            self.allFutureMindsError.send(.httpError)
        case .decoding:
            self.allFutureMindsError.send(.decoding)
        case .badHTTPResponse:
            self.allFutureMindsError.send(.badHTTPResponse)
        case .validationError:
            self.allFutureMindsError.send(.validationError)

        }
    }
}
