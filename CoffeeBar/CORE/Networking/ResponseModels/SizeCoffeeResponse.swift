//
//  SizeCoffeeResponse.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation

// MARK: - SizeCoffeeResponse
struct SizeCoffeeResponse: Decodable,ItemResponse {
    var id, name: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case v = "__v"
    }
}
