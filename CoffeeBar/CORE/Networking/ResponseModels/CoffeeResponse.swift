//
//  CoffeeResponse.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation

// MARK: - CoffeeResponse
struct CoffeeResponse: Decodable,ItemResponse {
    var id: String?
    var types: [TypeCoffeeResponse]?
    var sizes: [SizeCoffeeResponse]?
    var extras: [ExtraoffeeResponse]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case types, sizes, extras
    }
}
