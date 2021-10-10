//
//  OverviewViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import UIKit
import Combine

// MARK: - OverviewTableViewDiffableDataSource
class OverviewTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, OverviewCoffee> {}

// MARK: - OverviewViewModel
class OverviewViewModel {
    
    // MARK: - Proprieties
    //DiffableDataSource
    var itemsDiffableDataSource: OverviewTableViewDiffableDataSource?
    private(set) var itemsSnapshot = NSDiffableDataSourceSnapshot<Section, OverviewCoffee>()
    private var cancellables: Set<AnyCancellable> = []
    let dataArray : [OverviewCoffee] = OverviewCoffee().array
    
    init() {
        self.itemsSnapshot.appendSections([.main])
        self.itemsSnapshot.appendItems(dataArray, toSection: .main)
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
extension OverviewViewModel {
    public func applyDataSource() {
        guard let itemsDiffableDataSource = itemsDiffableDataSource else { return }
        itemsDiffableDataSource.apply(itemsSnapshot, animatingDifferences: true)
    }
}
