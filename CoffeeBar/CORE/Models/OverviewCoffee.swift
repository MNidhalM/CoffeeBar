//
//  OverviewCoffee.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import UIKit

// MARK: - Step
enum Step {
    case type
    case size
    case extra
}

// MARK: - OverviewCoffee
struct OverviewCoffee {
    var id, name: String?
    var image: UIImage?
    var step: Step?
    var subselections: [SubExtraCoffee]?
    var array = [OverviewCoffee]()
    
    init() {
        guard let type = Session.sharedInstance.typeCoffeeSelected,
              let size = Session.sharedInstance.sizeCoffeeSelected,
              let extras = Session.sharedInstance.extraCoffeSelected else {
            return
        }
        array.append(OverviewCoffee(from: type, step: .type))
        array.append(OverviewCoffee(from: size, step: .size))
        extras.forEach { item in
            array.append(OverviewCoffee(from: item, step: .extra,subselections: item.subselections))
        }
    }
    
    init<T: Item>(from item: T,step:Step,subselections: [SubExtraCoffee]? = nil) {
        id = item.id
        name = getName(itemName: item.name)
        image = item.image
        self.step = step
        self.subselections = subselections
    }
    
    private func getName(itemName: String?) -> String? {
        switch itemName {
        case .some("Select type of milk"):
            return  Constants.milk.rawValue
        case .some("Select the amount of sugar"):
            return  Constants.sugar.rawValue
        case .none, .some(_):
            return itemName
        }
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
