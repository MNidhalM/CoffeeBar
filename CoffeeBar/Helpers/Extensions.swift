//
//  Extensions.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

// MARK:  VIEW CONTROLLER
extension UIViewController
{
    class func instantiateFromStoryboard(_ name: String) -> Self
    {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T
    {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
}

extension UILabel {
    func underline() {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length ))
            attributedText = attributedString
        }
    }
}
//// MARK:  String
//extension String {
//    func htmlAttributedStringCSS(font: FontType, size: Int) -> NSAttributedString? {
//        return NSAttributedString(string: "hjg", attributes: [.underlineStyle: "hjg"])
////        let modifiedFont = String(format: "<span style=\"font-family: '\(font.rawValue)'; font-size: \(size)\">%@</span>", self)
//
////        return try? NSAttributedString(
////            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
////            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
////            documentAttributes: nil
////        )
//    }
//}

// MARK: UIVIEW
public extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

// MARK:  UITableViewCell
public extension UITableViewCell
{
    static var reuseIdentifier: String
    {
        return String(describing: self)
    }
}

extension UITableViewCell {
    
    func animateCell() {
        self.alpha = 0
        self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
    }
}

// MARK:  UITableView
extension UITableView {
    func animateTable() {
        self.alpha = 0
        self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
    }
}
