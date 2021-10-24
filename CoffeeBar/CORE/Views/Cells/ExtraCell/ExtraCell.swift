//
//  ExtraCell.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit

// MARK: - ExtraCell
class ExtraCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var selecteView: UIView!
    @IBOutlet weak var subExtraTableView: ContentSizedTableView!
    
    // MARK: - Proprieties
    private var extraCoffeeModel: ExtraCoffee?
    private weak var delegate: ExtraControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        registerCells()
    }
}

extension ExtraCell {
    // MARK: Configure table view
    private func setupTableView(){
        subExtraTableView.delegate = self
        subExtraTableView.dataSource = self
    }
    
    // MARK: Cell registration
    private func registerCells() {
        let cell = UINib(nibName: SubExtraCell.reuseIdentifier, bundle: nil)
        subExtraTableView.register(cell, forCellReuseIdentifier: SubExtraCell.reuseIdentifier)
    }
    
    public func updateCell(_ extraCoffee: ExtraCoffee, _ delegate: ExtraControllerDelegate?,animate: Bool) {
        animate ? animateCell() : ()
        self.extraCoffeeModel = extraCoffee
        self.delegate = delegate
        extraLabel.text = extraCoffee.name
        productImageView.image = extraCoffee.image
        subExtraTableView.reloadData()
    }
}

// MARK: UITableViewDataSource + UITableViewDelegate

extension ExtraCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let extraCoffeeModel = extraCoffeeModel,
              let subselections = extraCoffeeModel.subselections
        else {
            return 0
        }
        // TODO: guard
        return subselections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: guard
        guard let extraCoffeeModel = extraCoffeeModel,
            let subselections =  extraCoffeeModel.subselections,
            !subselections.isEmpty,
            indexPath.row < subselections.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: SubExtraCell.reuseIdentifier, for: indexPath) as? SubExtraCell
        else { return UITableViewCell() }
        
        let item = subselections[indexPath.row]
        cell.subExtraLabel.text = item.name
        cell.stateButton.isSelected = item.isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let subExtraModel = extraCoffeeModel?.subselections?[indexPath.row],
            let delegate = delegate
        else { return }
        
        // update data
        delegate.updateExtraState(extraCoffeeModel?.id, subExtraModel.id, isSelected: !subExtraModel.isSelected)
        
        // start reloatable view after the change on the data
        reloadCellsfunc(tableView: tableView)
    }
    
    func reloadCellsfunc (tableView: UITableView) {
        guard let delegate = delegate else { return }

        UIView.transition(with: delegate.subTableView, duration: 0.15, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            tableView.reloadData()
            self.delegate?.subTableView.reloadData()
        }, completion: { _ in
            tableView.layoutIfNeeded()
        })
    }
}
