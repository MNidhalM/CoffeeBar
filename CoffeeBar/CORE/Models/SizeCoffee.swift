//
//  SizeModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK: - Sizes

enum Sizes: Int {
    case small
    case medium
    case large
}

// MARK: - SizeCoffee
struct SizeCoffee: Item {
    var id, name: String?
    var isSelected : Bool = false
    var typeCoffeeCase : TypeCoffeeCases
    
    var size: Sizes {
        switch name {
        case "Large":
            return .large
        case "Medium", "Venti":
            return .medium
        case "Small", "Tall":
            return .small
        default:
            return .large
        }
    }
    
    var image : UIImage? {
        switch typeCoffeeCase {
        case .ristretto:
            return ImageAssets.largeLungo
        case .cappuccino:
            return ImageAssets.cappuchino
        case .espresso:
            return ImageAssets.espresso
        default:
            return ImageAssets.largeLungo
        }
    }
    
}

// MARK: - Hashable
extension SizeCoffee : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: SizeCoffee, rhs: SizeCoffee) -> Bool {
        return lhs.id == rhs.id
    }
}

