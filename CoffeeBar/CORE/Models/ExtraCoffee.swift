//
//  ExtraModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK: - ExtraCoffee
class ExtraCoffee: Item {
    var id, name: String?
    var subselections: [SubExtraCoffee]?
    var isSelected : Bool = false
    
    init(id: String?, name:String?, subselections: [SubExtraCoffee]?) {
        self.id = id
        self.name = name
        self.subselections = subselections
    }
    
    init(extra: ExtraoffeeResponse) {
        self.id = extra.id
        self.name = extra.name
        self.subselections = extra.subselections?.compactMap({ item in
            return SubExtraCoffee(subExtra: item)
        })
    }
    
    var image : UIImage? {
        switch name {
        case "Select type of milk":
            return ImageAssets.milk
        case "Select the amount of sugar":
            return ImageAssets.smallLungo
        default:
            return ImageAssets.smallLungo
        }
    }
}

// MARK: - Hashable
extension ExtraCoffee :Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ExtraCoffee, rhs: ExtraCoffee) -> Bool {
        return lhs.id == rhs.id
    }
}
