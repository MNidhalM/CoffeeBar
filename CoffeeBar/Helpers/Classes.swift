//
//  Classes.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK:  Section
enum Section {case main}

// MARK:  BaseViewControllerProtocol
protocol BaseViewControllerProtocol {
    func setupTableView()
    func setupObservers()
    func registerCells()
    func setupUI()
}

extension BaseViewControllerProtocol {
    func setupObservers() {}
}

// MARK:  URLs
public enum URLs: String {
    case getCoffes              = "coffee-machine/"
}

// MARK:  FontType
enum FontType: String {
    case regular = "AvenirNext-Regular"
    case medium = "AvenirNext-Medium"
    case bold = "AvenirNext-Bold"
}

// MARK:  ContentSizedTableView
final class ContentSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
