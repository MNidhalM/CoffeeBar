//
//  ItemProtocol.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit

protocol Item {
    var id: String? {get set}
    var name: String? {get set}
    var image: UIImage? {get}
    var isSelected : Bool{get set}
}
