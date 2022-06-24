//
//  Errors.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 24.06.2022.
//

import Foundation
import UIKit

enum RequestError: Error {
    case noInternet
    case wrongToken
    case noRights
    case readmeNotFound
    case noRepositories
    case unknown(code: Int)
}

extension RequestError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("NO_INTERNET", comment: "")
        case .wrongToken:
            return NSLocalizedString("WRONG_TOKEN", comment: "")
        case .noRights:
            return NSLocalizedString("NO_RIGHTS", comment: "")
        case .readmeNotFound:
            return NSLocalizedString("README_NOT_FOUND", comment: "")
        case .noRepositories:
            return NSLocalizedString("EMPTY", comment: "")
        case .unknown:
            return NSLocalizedString("UNKNOWN_ERROR", comment: "")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .unknown(let code):
            return "\(code)"
        default:
            return nil
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("NO_INTERNET_SUGGESTION", comment: "")
        case .wrongToken:
            return NSLocalizedString("WRONG_TOKEN_SUGGESTION", comment: "")
        case .noRights:
            return NSLocalizedString("NO_RIGHTS_SUGGESTION", comment: "")
        case .readmeNotFound:
            return NSLocalizedString("README_NOT_FOUND_SUGGESTION", comment: "")
        case .noRepositories:
            return NSLocalizedString("NO_REPOSITORIES", comment: "")
        case .unknown:
            return NSLocalizedString("UNKNOWN_ERROR_SUGGESTION", comment: "")
        }
    }
}

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
