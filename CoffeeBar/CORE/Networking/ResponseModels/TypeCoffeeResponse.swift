//
//  TypeCoffeeResponse.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation

// MARK: - TypeCoffeeResponse
struct TypeCoffeeResponse: Decodable,ItemResponse {
    var id, name: String?
    var sizes, extras: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, sizes, extras
    }
}
