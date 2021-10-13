//
//  OverviewViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import UIKit
import Combine

protocol OverviewViewModelType {
    func applyDataSource()
    func removeCancellables()
    var itemsDiffableDataSource: OverviewTableViewDiffableDataSource? {get set}
    var itemsSnapshot : NSDiffableDataSourceSnapshot<Section, OverviewCoffee> {get set}

}
// MARK: - OverviewTableViewDiffableDataSource
class OverviewTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, OverviewCoffee> {}

// MARK: - OverviewViewModel
class OverviewViewModel: OverviewViewModelType {
    
    // MARK: - Proprieties
    //DiffableDataSource
    var itemsDiffableDataSource: OverviewTableViewDiffableDataSource?
    var itemsSnapshot = NSDiffableDataSourceSnapshot<Section, OverviewCoffee>()
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
    func applyDataSource() {
        guard let itemsDiffableDataSource = itemsDiffableDataSource else { return }
        itemsDiffableDataSource.apply(itemsSnapshot, animatingDifferences: true)
    }
}
