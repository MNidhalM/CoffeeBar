//
//  ColorAssets.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit

enum Color {
    case darkGreen
    case lightGreen
}

extension Color {
    var rawValue: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .darkGreen:
            instanceColor = UIColor(named: "DarkGreen") ?? UIColor.clear
        case .lightGreen:
            instanceColor = UIColor(named: "LightGreen") ?? UIColor.clear
        }
        return instanceColor
    }
}
