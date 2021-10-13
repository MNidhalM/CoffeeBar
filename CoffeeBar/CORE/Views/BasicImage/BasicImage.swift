//
//  File.swift
//  CoffeeBar
//
//  Created by Nidhal on 13/10/2021.
//

import UIKit

class BasicImage: NibLoadingView {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUIStyle()
    }
    
    public func configureView(image: UIImage, size: Sizes) {
        productImageView.image = image
        switch size {
        case .small:
            heightImageView.constant = 20
        case .medium:
            heightImageView.constant = 30
        case .large:
            heightImageView.constant = 45
        }
        self.layoutIfNeeded()
    }
    
    private func setupUIStyle() {
        
    }

}
