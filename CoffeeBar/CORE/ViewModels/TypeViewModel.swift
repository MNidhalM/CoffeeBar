//
//  TypeViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit
import Combine

protocol TypeViewModelType {
    func applyDataSource()
    func canSelectObject(index: Int) -> Bool
    var itemsDiffableDataSource: TypeTableViewDiffableDataSource? {get set}
    var itemsSnapshot : NSDiffableDataSourceSnapshot<Section, TypeCoffee> {get set}
}

// MARK: - TypeTableViewDiffableDataSource
class TypeTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, TypeCoffee> {}

// MARK: - TypeViewModel
class TypeViewModel: TypeViewModelType {
    
    // MARK: - Proprieties
    // DiffableDataSource
    var itemsDiffableDataSource: TypeTableViewDiffableDataSource?
    var itemsSnapshot = NSDiffableDataSourceSnapshot<Section, TypeCoffee>()
    private var cancellables: Set<AnyCancellable> = []
    let coffees = PassthroughSubject<[TypeCoffee], Never>()
    init() {
        self.coffees
            .receive(on: RunLoop.main)
            .sink { print($0) } receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.itemsSnapshot.appendSections([.main])
                self.itemsSnapshot.appendItems(items, toSection: .main)
                self.applyDataSource()
            }
            .store(in: &cancellables)
        guard let coffees = SessionManager.sharedInstance.typeCoffeeArray else { return }
        self.coffees.send(coffees)
    }
    
    public func removeCancellables(){
        itemsDiffableDataSource = nil
        cancellables.removeAll()
    }
    
    deinit {
        removeCancellables()
    }    
}

// MARK: - Helpers
extension TypeViewModel {
    func applyDataSource() {
        guard let itemsDiffableDataSource = itemsDiffableDataSource else { return }
        itemsDiffableDataSource.apply(itemsSnapshot, animatingDifferences: true)
    }

    func canSelectObject(index: Int) -> Bool {
        guard index < itemsSnapshot.numberOfItems else { return false}
        let selectedItem = itemsSnapshot.itemIdentifiers[index]
        SessionManager.sharedInstance.typeCoffeeSelected = selectedItem
        return true
    }
}
