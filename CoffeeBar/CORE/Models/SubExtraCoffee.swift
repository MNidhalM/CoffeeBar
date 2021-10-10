//
//  SubExtraCoffee.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit
import Combine

// MARK: - SubExtraCoffee
class SubExtraCoffee: Item, Hashable {
    var id, name: String?
    var isSelected : Bool = false
    var image: UIImage?
    
    init(subExtra: SubExtraCoffeeResponse) {
        self.id = subExtra.id
        self.name = subExtra.name
    }
}

// MARK: - Hashable
extension SubExtraCoffee {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: SubExtraCoffee, rhs: SubExtraCoffee) -> Bool {
        return lhs.id == rhs.id
    }

}
