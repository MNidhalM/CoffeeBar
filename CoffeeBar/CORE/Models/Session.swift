//
//  SessionManager.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import Foundation
protocol SessionManager {
    var typeCoffeeArray: [TypeCoffee]? { get set }
    var sizeCoffeeArray: [SizeCoffee]? { get set }
    var extraCoffeArray: [ExtraCoffee]? { get set }
    var typeCoffeeSelected: TypeCoffee? { get set }
    var sizeCoffeeSelected: SizeCoffee? { get set }
    var extraCoffeSelected: [ExtraCoffee]? { get set }
    func cleanSession()
}

// MARK:  Session
class Session :  SessionManager {
    static var sharedInstance = Session()
    private init (){
    }
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
    func cleanSession() {
        typeCoffeeSelected = nil
        sizeCoffeeSelected = nil
        cleanExtras(extras: extraCoffeArray)
    }
}
