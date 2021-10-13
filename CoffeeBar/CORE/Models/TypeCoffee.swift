//
//  Models.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK: - TypeCoffeeCases
enum TypeCoffeeCases {
    case ristretto
    case espresso
    case cappuccino
    case others
}

// MARK: - TypeCoffee
struct TypeCoffee: Item {
    var id, name: String?
    var sizes: [SizeCoffee]?
    var extras: [ExtraCoffee]?
    var isSelected : Bool = false
    
    var typeCoffeeCase : TypeCoffeeCases {
        switch name {
        case .some("Ristretto"):
            return  .ristretto
        case .some("Espresso"):
            return  .espresso
        case .some("Cappuccino"):
            return  .cappuccino
        case .none, .some(_):
            return .others
        }
    }
    
    var image : UIImage? {
        switch name {
        case "Espresso":
            return ImageAssets.espresso
        case "Cappuccino":
            return ImageAssets.cappuchino
        case "Lungo":
            return ImageAssets.lungo
        default:
            return ImageAssets.largeLungo
        }
    }
    
    init(from responseModel: TypeCoffeeResponse,sizesIds:[SizeCoffeeResponse],extrasIds:[ExtraoffeeResponse]) {
        self.id = responseModel.id
        self.name = responseModel.name
        self.sizes = collectDataSize(ids: responseModel.sizes, objectArray: sizesIds, typeCoffeeCase: typeCoffeeCase)
        self.extras = collectDataExtra(ids: responseModel.extras, objectArray: extrasIds)
    }
}

// MARK: - Hashable
extension TypeCoffee : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: TypeCoffee, rhs: TypeCoffee) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Helpers
extension TypeCoffee {
    private func collectDataSize(ids: [String]?,objectArray:[SizeCoffeeResponse],typeCoffeeCase : TypeCoffeeCases) -> [SizeCoffee] {
        objectArray.filter { item in
            guard let id = item.id else { return false}
            return ids?.contains(id) ?? false
        }.compactMap { item in
            return SizeCoffee(id: item.id, name: item.name, typeCoffeeCase: typeCoffeeCase)
        }
    }
    
    private func collectDataExtra(ids: [String]?,objectArray:[ExtraoffeeResponse]) -> [ExtraCoffee] {
        objectArray.filter { item in
            guard let id = item.id else { return false}
            return ids?.contains(id) ?? false
        }.compactMap { item in
            return ExtraCoffee(extra: item)
        }
    }
}
