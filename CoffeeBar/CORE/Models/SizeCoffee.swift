//
//  SizeModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK: - SizeCoffee
struct SizeCoffee: Item {
    var id, name: String?
    var isSelected : Bool = false
    
    var image : UIImage? {
        switch name {
        case "Large":
            return ImageAssets.largeLungo
        case "Medium":
            return ImageAssets.mediumLungo
        case "Small":
            return ImageAssets.smallLungo
        default:
            return ImageAssets.smallLungo
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

