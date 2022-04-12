//
//  MockFutureMindResponse.swift
//  FutureMindTests
//
//  Created by Krzysztof Lema on 12/04/2022.
//

import Foundation
@testable import FutureMind
extension FutureMindResponse{
    static func mock() -> FutureMindResponse {
        FutureMindResponse(description: "", imageUrl: "", modificationDate: "", orderId: 1, title: "")
    }
}

struct WrongFutureMindResponse: Encodable {}
