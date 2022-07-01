//
//  UIViewCotrollerExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorView(_ errorView: ErrorView!, error: RequestError, onButtonTap: @escaping() -> ()) {
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
    
    func hideErrorView(_ errorView: ErrorView!){
        errorView.isHidden = true
    }
    
    func showAlert(msg: String, sender: UIView) {
        let alertController = UIAlertController(title:
               msg, message: nil,
               preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
               style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(for error: RequestError, sender: UIView){
        var msg = NSLocalizedString("ERROR", comment: "")
        switch error {
        case .unknown:
            msg.append(contentsOf: "\n\(error.failureReason!)")
            msg.append(contentsOf: NSLocalizedString("INFO_FOR_DEVELOPERS", comment: ""))
        default:
            msg.append(contentsOf: "\n\(error.errorDescription!)\n\(error.recoverySuggestion!)")
        }
        showAlert(msg: msg, sender: sender)
    }
    
    func setExitButton(){
        let exitButton = UIBarButtonItem(image: UIImage(named: "exit"),
                                         style: UIBarButtonItem.Style.plain,
                                         target: self, action: #selector(self.onExitTapped))
        exitButton.tintColor = UIColor.white
        navigationItem.setRightBarButton(exitButton, animated: true)
    }
    
    @IBAction func onExitTapped() {
        AppRepository.shared.signOut()
        navigationController?.setViewControllers([AuthViewController()], animated: true)
    }
}
