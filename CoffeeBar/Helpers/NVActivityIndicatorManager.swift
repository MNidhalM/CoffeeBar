//
//  NVActivityIndicatorManager.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class NVActivityIndicatorManager {
    static var preferedFontName: String = ""

    static func hideLoader()
    {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }

    static func showLoader(shouldShow: Bool = true, loaderMessage: String, loaderType: NVActivityIndicatorType = .circleStrokeSpin)
    {
        guard shouldShow else { return }
        
        DispatchQueue.main.async {
            guard !NVActivityIndicatorPresenter.sharedInstance.isAnimating else { return }
            
            let activityData = ActivityData(message: loaderMessage,
                                            messageFont: UIFont(name: preferedFontName, size: 19) ?? UIFont.boldSystemFont(ofSize: 19),
                                            type: loaderType,
                                            color: .white,
                                            minimumDisplayTime: 1)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }

}
