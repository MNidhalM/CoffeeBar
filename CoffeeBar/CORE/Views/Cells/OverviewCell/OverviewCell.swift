//
//  OverviewCell.swift
//  CoffeeBar
//
//  Created by Nidhal on 10/10/2021.
//

import UIKit

// MARK: - OverviewCell
class OverviewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var subExtraLine: UIView!
    @IBOutlet weak var extraLine: UIView!
    @IBOutlet weak var subItemStackView: UIStackView!
    @IBOutlet weak var subItemLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension OverviewCell {
    public func setupCell(item: OverviewCoffee,limits:(first:Bool,last :Bool)) {
        if limits.first{
            // add top corner to the first cell
            containerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 4
        }
        
        if limits.last{
            // add bottom corner to the last cell
            containerView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 4
        }
        
        // setup Overview data
        itemLabel.text = item.name
        (item.image != nil) ? itemImageView.image = item.image : (itemImageView.isHidden = true)
        
        // setup subExtra data and UI
        if let subExtras = item.subselections , !subExtras.isEmpty {
            let subExtra = subExtras.first { item in
                item.isSelected
            }
            guard let subExtraUnwrapped = subExtra else { return }
            subItemStackView.isHidden = false
            subItemLabel.text = subExtraUnwrapped.name
            limits.last ? (subExtraLine.isHidden = true) : (subExtraLine.isHidden = false)
        } else {
            subItemStackView.isHidden = true
            limits.last ? (extraLine.isHidden = true) : (extraLine.isHidden = false)
        }
    }
    
}
