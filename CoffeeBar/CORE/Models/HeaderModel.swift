//
//  HeaderModel.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import Foundation

enum HeaderModel {
    case scan
    case type
    case size
    case extra
    case overview
    
    var title: String {
        switch self {
        case .scan:
            return Constants.scan_title.rawValue
        case .type:
            return Constants.common_title.rawValue
        case .size:
            return Constants.common_title.rawValue
        case .extra:
            return Constants.common_title.rawValue
        case .overview:
            return Constants.common_title.rawValue
        }
    }
    
    var subTitle: String {
        switch self {
        case .scan:
            return Constants.scan_subtitle.rawValue
        case .type:
            return Constants.type_subtitle.rawValue
        case .size:
            return Constants.aize_subtitle.rawValue
        case .extra:
            return Constants.extra_subtitle.rawValue
        case .overview:
            return Constants.overview_subtitle.rawValue
        }
    }
    
}
