//
//  SubExtraCoffeeResponse.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation

// MARK: - SubExtraCoffeeResponse
struct SubExtraCoffeeResponse: Decodable,ItemResponse {
    var id, name: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
