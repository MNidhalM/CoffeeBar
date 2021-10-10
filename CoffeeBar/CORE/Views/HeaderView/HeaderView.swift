//
//  HeaderView.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit


class HeaderView: NibLoadingView {
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped(_ sender: Any) {
        backButtonDidTappedCallback?()
    }
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var backButtonDidTappedCallback: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUIStyle()
    }
    
    public func configureView(mode: HeaderModel) {
        titleLabel.text = mode.title
        subtitleLabel.text = mode.subTitle
        if (mode == .scan || mode == .type) {
            backButton.isHidden = true
        }
    }
    
    private func setupUIStyle() {
        
    }
}
