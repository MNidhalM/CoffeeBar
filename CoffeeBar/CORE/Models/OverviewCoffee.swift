//
//  OverviewCoffee.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import UIKit

// MARK: - OverviewCoffee
struct OverviewCoffee {
    var id, name: String?
    var image: UIImage?
    var subselections: [SubExtraCoffee]?
    var array = [OverviewCoffee]()

    init() {
        guard let type = SessionManager.sharedInstance.typeCoffeeSelected,
              let size = SessionManager.sharedInstance.sizeCoffeeSelected,
              let extras = SessionManager.sharedInstance.extraCoffeSelected else {
            return
        }
        array.append(OverviewCoffee(from: type))
        array.append(OverviewCoffee(from: size))
        extras.forEach { item in
            array.append(OverviewCoffee(from: item,subselections: item.subselections))
        }
    }

    init<T: Item>(from item: T,subselections: [SubExtraCoffee]? = nil) {
        id = item.id
        name = item.name
        image = item.image
        self.subselections = subselections
    }
}

// MARK: - Hashable
extension OverviewCoffee : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: OverviewCoffee, rhs: OverviewCoffee) -> Bool {
        return lhs.id == rhs.id
    }
}
