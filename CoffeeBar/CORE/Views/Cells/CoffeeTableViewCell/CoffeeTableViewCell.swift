//
//  CoffeeTableViewCell.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK: - CoffeeTableViewCell
class CoffeeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: BasicImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Helpers
extension CoffeeTableViewCell {
    public func setupCell<T: Item>(item: T,size: Sizes) {
        animateCell()
        titleLabel.text = item.name
        guard let image = item.image else { productImageView.isHidden = true; return }
        productImageView.configureView(image: image, size: size)
    }
    
}
