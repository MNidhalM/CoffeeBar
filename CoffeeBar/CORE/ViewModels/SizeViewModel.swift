//
//  SizeViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit
import Combine

protocol SizeViewModelType {
    func applyDataSource()
    func canSelectObject(index: Int) -> Bool
    var itemsDiffableDataSource: SizeTableViewDiffableDataSource? {get set}
    var itemsSnapshot : NSDiffableDataSourceSnapshot<Section, SizeCoffee> {get set}
}

// MARK: - SizeTableViewDiffableDataSource
class SizeTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, SizeCoffee> {}

// MARK: - SizeViewModel
class SizeViewModel: SizeViewModelType {
    
    // MARK: - Proprieties
    // DiffableDataSource
    var itemsDiffableDataSource: SizeTableViewDiffableDataSource?
    var itemsSnapshot = NSDiffableDataSourceSnapshot<Section, SizeCoffee>()
    private var cancellables: Set<AnyCancellable> = []
    let dataArray : [SizeCoffee]?
    var sessionManager : SessionManager
    
    init(sizeCoffeeArray: [SizeCoffee]?, sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        guard let sizeCoffeeArray = sizeCoffeeArray else { dataArray = nil; return}
        dataArray = sizeCoffeeArray.sorted { $0.size.rawValue < $1.size.rawValue}
        itemsSnapshot.appendSections([.main])
        itemsSnapshot.appendItems(dataArray!, toSection: .main)
        applyDataSource()
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
extension SizeViewModel {
    
    func applyDataSource() {
        guard let itemsDiffableDataSource = itemsDiffableDataSource else { return }
        itemsDiffableDataSource.apply(itemsSnapshot, animatingDifferences: true)
    }
    
    func canSelectObject(index: Int) -> Bool {
        guard index < itemsSnapshot.numberOfItems else { return false}
        let selectedItem = itemsSnapshot.itemIdentifiers[index]
        sessionManager.sizeCoffeeSelected = selectedItem
        return true
    }
}
