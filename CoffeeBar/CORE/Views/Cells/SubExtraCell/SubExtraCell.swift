//
//  SubExtraCell.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit

// MARK: - SubExtraCell
class SubExtraCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var subExtraLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stateButton.setImage(#imageLiteral(resourceName: "selected"), for: .selected)
        stateButton.setImage(#imageLiteral(resourceName: "unselected"), for: .normal)
    }
    
}
