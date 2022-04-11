//
//  futureMind.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 09/04/2022.
//

import Foundation

struct FutureMind: Hashable {
    let description: String
    let imageUrl: URL?
    let modificationDate: String
    let orderId: Int
    let title: String
    let futureMindDetailURL: URL?

    init(futureMindResponse: FutureMindResponse) {
        self.description = futureMindResponse.description.removingUrls()
        self.imageUrl = URL(string: futureMindResponse.imageUrl)
        self.modificationDate = futureMindResponse.modificationDate
        self.orderId = futureMindResponse.orderId
        self.title = futureMindResponse.title
        self.futureMindDetailURL = URL(string: futureMindResponse.imageUrl.detectUrl())
    }
}
