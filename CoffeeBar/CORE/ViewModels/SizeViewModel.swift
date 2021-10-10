//
//  SizeViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit
import Combine

// MARK: - SizeTableViewDiffableDataSource
class SizeTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, SizeCoffee> {}

// MARK: - SizeViewModel
class SizeViewModel {
    
    // MARK: - Proprieties
    // DiffableDataSource
    var itemsDiffableDataSource: SizeTableViewDiffableDataSource?
    private(set) var itemsSnapshot = NSDiffableDataSourceSnapshot<Section, SizeCoffee>()
    private var cancellables: Set<AnyCancellable> = []
    let dataArray : [SizeCoffee]?
    
    init() {
        guard let sizeCoffeeArray = SessionManager.sharedInstance.sizeCoffeeArray else { dataArray = nil; return}
        dataArray = sizeCoffeeArray
        itemsSnapshot.appendSections([.main])
        itemsSnapshot.appendItems(sizeCoffeeArray, toSection: .main)
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
    public func applyDataSource() {
        guard let itemsDiffableDataSource = itemsDiffableDataSource else { return }
        itemsDiffableDataSource.apply(itemsSnapshot, animatingDifferences: true)
    }
}
