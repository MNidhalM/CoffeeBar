//
//  CoffeeServiceManager.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation
import Combine
// MARK: - CoffeeServiceManager

class CoffeeServiceManager {
    static let sharedService = CoffeeServiceManager()

    func getCoffeeData(coffeeMachineId: String) -> AnyPublisher<CoffeeResponse?, NetworkingError> {
        return NetworkingManager.shared.getData(urlString: "\(URLs.getCoffes.rawValue)\(coffeeMachineId)")
    }
}
