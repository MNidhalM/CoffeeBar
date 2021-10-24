//
//  TagsModalViewModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation
import UIKit

protocol ExtraViewModelType {
    var dataCount : Int  {get}
    func isDataExistAndValid(index: Int) -> Bool
    func updateFromSubExtra(_ extraId: String?, _ subExtraId: String?, isSelected: Bool)
}

// MARK: - ExtraViewModel
class ExtraViewModel: ExtraViewModelType {
    func isDataExistAndValid(index: Int) -> Bool {
        guard !allExtras.isEmpty,
              index < allExtras.count else {return false}
        return true
    }
    
    var dataCount: Int {
        return allExtras.count
    }
    
    
    // MARK: - Proprieties
    var allExtras = [ExtraCoffee]()
    var selectedSubExtras: ExtraCoffee?
    var sessionManager : SessionManager
    
    init(extraCoffeArray: [ExtraCoffee]?, sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        guard let extraCoffeArray = extraCoffeArray else { return}
        
        allExtras = extraCoffeArray
    }
}

// MARK: - Helpers
extension ExtraViewModel {
    // unselected all cells under parent cell with extraId
    private func makeUnSelectedCellExtras(extraId: String?) {
        allExtras
            .forEach {
                if $0.id == extraId {
                    $0.subselections?
                        .forEach {
                            $0.isSelected = false
                        }
                }
            }
    }
    
    // select sub extra cell
    public func updateFromSubExtra(_ extraId: String?, _ subExtraId: String?, isSelected: Bool) {
        makeUnSelectedCellExtras(extraId: extraId)
        if let extra = allExtras.first(where: { $0.id == extraId }) {
            extra.subselections?.first { $0.id == subExtraId }?.isSelected = isSelected
            extra.isSelected = isSelected
        }
    }
    
    // get the user's selection
    public func collectSelection() {
        sessionManager.extraCoffeSelected = []
        allExtras.forEach { extra in
            if (extra.subselections?.first(where: { subExtra in
                subExtra.isSelected
            })) != nil {
                sessionManager.extraCoffeSelected?.append(extra)
            }
        }
    }
}
