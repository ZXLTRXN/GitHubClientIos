//
//  UIViewCotrollerExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(errorView: ErrorView!, error: RequestError, onButtonTap: @escaping() -> ()) {
        var image: UIImage
        var color: UIColor
        var buttonTitle: String
        
        switch error {
        case .noRepositories:
            image = UIImage(named: "empty")!
            color = UIColor(named: "DefaultBlue")!
            buttonTitle = NSLocalizedString("REFRESH", comment: "")
        case .noInternet:
            image = UIImage(named: "connectionError")!
            color = UIColor(named: "ErrorRed")!
            buttonTitle = NSLocalizedString("RETRY", comment: "")
        default:
            image = UIImage(named: "somethingError")!
            color = UIColor(named: "ErrorRed")!
            buttonTitle = NSLocalizedString("RETRY", comment: "")
        }
        
        errorView.setUI(image: image, description: error.errorDescription!,
                        suggestion: error.recoverySuggestion!,
                        color: color, buttonTitle: buttonTitle, onButtonTap: onButtonTap)
        errorView.isHidden = false
    }
    
    func hideError(errorView: ErrorView!){
        errorView.isHidden = true
    }
}
