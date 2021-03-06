//
//  ScanViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 8/10/2021.
//

import Foundation
import Combine

protocol ScanViewModelType {
    var coffees : PassthroughSubject<[TypeCoffee], Never> {get set}
}

// MARK: - ScanViewModel
class ScanViewModel: ScanViewModelType {
    
    // MARK: - Proprieties
    var coffees = PassthroughSubject<[TypeCoffee], Never>()
    private var service : CoffeeService
    var sessionManager : SessionManager
    private var cancellables: Set<AnyCancellable> = []
    
    init(observer: PassthroughSubject<String, Never>, service: CoffeeService, sessionManager: SessionManager) {
        self.service = service
        self.sessionManager = sessionManager
        observer
            .receive(on: RunLoop.main)
            .sink { print($0) }
                receiveValue: { [weak self] coffeeMachineId in
                    guard let self = self else { return }
                    self.getCoffeeData(id: coffeeMachineId)
                }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}

// MARK: - Helpers
extension ScanViewModel {
    // Call serviceManager to get data related the machine id
    private func getCoffeeData(id :String) {
        service.loadItems(coffeeMachineId: id)
            .receive(on: RunLoop.main)
            .sink { completed in
                switch completed {
                case .finished: break
                case .failure(let error):
                    ToastHelper.showToast(failure: true, message: error.description)
                }
            }
            receiveValue: { [weak self] response in
                guard let self = self ,let response = response else { return }
                guard
                    let types = response.types,
                    let sizes = response.sizes,
                    let extras = response.extras else {ToastHelper.showToast(failure: true, message: NetworkingError(status: .missingData).description); return }
                
                let arrayTypes :[TypeCoffee]  = types.compactMap { item in
                    return TypeCoffee(from: item, sizesIds: sizes, extrasIds: extras)
                }
                
                self.sessionManager.typeCoffeeArray = arrayTypes
                // send new value
                self.coffees.send(arrayTypes)
            }
            .store(in: &cancellables)
    }
    
}
