//
//  SessionManager.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import Foundation

// MARK:  SessionManager
class SessionManager {
    static var sharedInstance = SessionManager()
    
    var typeCoffeeSelected: TypeCoffee?{
        didSet {
            cleanExtras(extras: typeCoffeeSelected?.extras)
            sizeCoffeeArray = typeCoffeeSelected?.sizes
            extraCoffeArray = typeCoffeeSelected?.extras
        }
    }
    var sizeCoffeeSelected: SizeCoffee?
    var extraCoffeSelected: [ExtraCoffee]?
    
    var typeCoffeeArray: [TypeCoffee]?
    var sizeCoffeeArray: [SizeCoffee]?
    var extraCoffeArray: [ExtraCoffee]?
    
    func cleanExtras(extras: [ExtraCoffee]?) {
        extras?.forEach {
            $0.isSelected = false
            $0.subselections?.forEach {
                $0.isSelected = false
            }
        }
    }
    
    /// clean the selected items
    public func cleanSession() {
        typeCoffeeSelected = nil
        sizeCoffeeSelected = nil
        cleanExtras(extras: extraCoffeArray)
    }
}
