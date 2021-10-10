//
//  Toast.swift
//  CoffeeBar
//
//  Created by Nidhal on 8/10/2021.
//

import UIKit

class ToastHelper {
    static var preferedFontName: String = FontType.regular.rawValue
    static var isPresentingToast = false
    static var toastDuration: Double = 0.5
    static var successToastBaseColor: UIColor = #colorLiteral(red: 0.3396788239, green: 0.6912397146, blue: 0.3835897744, alpha: 1)
    static var failureToastBaseColor: UIColor = #colorLiteral(red: 0.9098039216, green: 0.5098039216, blue: 0.5176470588, alpha: 1)
    
    /// show Toast,  there are two types of color  failure or success
    static func showToast(failure: Bool = false, message: String, droppedUp: Bool = false) {
        guard
            !message.isEmpty,
            !isPresentingToast else
        { return }
        
        DispatchQueue.main.async {
            
            guard let keyWindow: UIWindow = UIApplication.shared.delegate?.window ?? UIWindow() else { return }
            
            let localizedMessage = message
            let button = UIButton(frame: CGRect.zero)
            button.setImage(UIImage(named: failure ? "icon_failed": "checkmark"), for: .normal)
            button.imageView?.tintColor = failure ? failureToastBaseColor: successToastBaseColor
            button.contentHorizontalAlignment = .center
            button.titleLabel?.textAlignment = .center
            button.setTitle(localizedMessage, for: .normal)
            button.titleLabel?.font = UIFont(name: preferedFontName, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
            button.layer.borderColor = failure ? failureToastBaseColor.cgColor: successToastBaseColor.cgColor
            button.layer.borderWidth =  0.5
            button.backgroundColor = .white
            button.setTitleColor(failure ? failureToastBaseColor: successToastBaseColor, for: .normal)
            button.titleLabel?.numberOfLines = 4
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            let attributedString = NSMutableAttributedString(string: localizedMessage)
            attributedString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            button.setAttributedTitle(attributedString, for: .normal)
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
            button.isUserInteractionEnabled = false
            button.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
            button.titleEdgeInsets = .init(top: 12, left: 12, bottom: 12, right: 12)
            var buttonWidth = ToastHelper().width(text: localizedMessage, withConstrainedHeight: 15, font: UIFont(name: preferedFontName, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)) + 50
            if buttonWidth > keyWindow.frame.width - 100
            {
                buttonWidth = keyWindow.frame.width - 100
            }
            let buttonheight = ToastHelper().height(text: localizedMessage, withConstrainedWidth: keyWindow.frame.size.width - 100, font: UIFont(name: preferedFontName, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)) + 25
            let abscisse = (keyWindow.frame.width/2) - (buttonWidth/2)
            button.frame = CGRect.init(x: abscisse, y: keyWindow.frame.maxY, width: buttonWidth, height: buttonheight )
            keyWindow.endEditing(true)
            keyWindow.addSubview(button)
            
            var basketTopFrame: CGRect = button.frame
            basketTopFrame.origin.x = abscisse
            basketTopFrame.origin.y = keyWindow.frame.maxY - (droppedUp ? 170: 70) - button.frame.height
            
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                button.frame = basketTopFrame
                isPresentingToast = true
            },completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + (failure ? toastDuration: toastDuration)) {
                    UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                        button.alpha = 0
                    },completion: { _ in
                        isPresentingToast = false
                        button.removeFromSuperview()
                    })
                }
            })
        }
    }
    
    private func width(text: String, withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    private func height(text: String, withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
}
