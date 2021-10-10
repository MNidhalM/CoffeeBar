//
//  ExtraCoffeeResponse.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation

// MARK: - ExtraoffeeResponse
struct ExtraoffeeResponse: Decodable,ItemResponse {
    var id, name: String?
    var subselections: [SubExtraCoffeeResponse]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, subselections
    }
}
