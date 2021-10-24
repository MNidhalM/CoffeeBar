//
//  CoffeeServiceManager.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation
import Combine
// MARK: - CoffeeServiceManager

protocol  CoffeeService {
    func loadItems(coffeeMachineId: String) -> AnyPublisher<CoffeeResponse?, NetworkingError>
}

struct CoffeeServiceAdapter:  CoffeeService {
    let api : NetworkingManager
    
    func loadItems(coffeeMachineId: String) -> AnyPublisher<CoffeeResponse?, NetworkingError> {
        return api.getData(urlString: "\(URLs.getCoffes.rawValue)\(coffeeMachineId)")
    }
}
