//
//  FutureMindResponse.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 10/04/2022.
//

import Foundation

public struct FutureMindResponse: Decodable, Hashable, Encodable {
    let description: String
    let imageUrl: String
    let modificationDate: String
    let orderId: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case description
        case imageUrl = "image_url"
        case modificationDate
        case orderId
        case title
    }
}
