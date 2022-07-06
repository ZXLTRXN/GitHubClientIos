//
//  AuthViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 17.06.2022.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var tokenTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var activityIndicator: MDCActivityIndicator!
    
    private let appRepo = AppRepository.shared
    
    private let borderRadius: CGFloat = 8
    private var editState: EditState = .valid
    private var validationEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenTextField.delegate = self
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUI() {
        tokenTextField.placeholder = NSLocalizedString("auth.tokenTextField.placeholder", comment: "")
        
        signInButton.setTitle(NSLocalizedString("auth.signInButton.title", comment: ""), for: .normal)
        signInButton.layer.cornerRadius = borderRadius
        signInButton.clipsToBounds = true
        signInButton.setTitleColor(signInButton.backgroundColor, for: .disabled)
        
        activityIndicator.setColor()
    }
    
    private func onLoading(started flag: Bool) {
        tokenTextField.isEnabled = !flag
        signInButton.isEnabled = !flag
        if flag {
            activityIndicator.show()
        } else {
            activityIndicator.hide()
        }
    }
    
    @IBAction private func signInTapped(_ sender: UIButton) {
        if !validationEnabled {
            validationEnabled = true
            checkValidation(onValid: setIdleState)
        }
        if editState == .valid {
            onLoading(started: true)
            guard let token = tokenTextField.text else { return }
            appRepo.signIn(token: token) {[weak self] error in
                self?.onLoading(started: false)
                guard let error = error else {
                    self?.navigationController?.setViewControllers([RepositoriesListViewController()], animated: true)
                    return
                }
                self?.showAlert(for: error, sender: sender)
            }
        }
    }
    
    // MARK: textField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkValidation(onValid: setIdleState)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidation(){
            textField.removeBorder()
        }
    }
    
    @IBAction private func editingChanged(_ sender: UITextField) {
        checkValidation(onValid: setIdleState)
    }
    //
    
    private func checkValidation(onValid: () -> Void) {
        if validationEnabled {
            editState = validateToken(tokenTextField.text)
            switch (editState) {
            case .invalid:
                setTokenErrorState(message: NSLocalizedString("auth.inputErrorLabel.invalidToken.title", comment: ""))
            case .empty:
                setTokenErrorState(message: NSLocalizedString("auth.inputErrorLabel.emptyToken.title", comment: ""))
            case .valid:
                onValid()
            }
        } else {
            onValid()
        }
    }
    
    private func validateToken(_ token: String?) -> EditState {
        if token == nil || token == "" {
            return .empty
        }
        let regularExpression = "[A-Za-z0-9_]{20,40}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        if predicate.evaluate(with: token){
            return .valid
        } else {
            return .invalid
        }
    }
    
    private func setTokenErrorState(message: String) {
        let redColor = UIColor(named: "ErrorRed")
        tokenTextField.setBorderColor(redColor?.cgColor, borderRadius)
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    private func setIdleState() {
        tokenTextField.setBorderColor(UIColor(named: "DefaultBlue")?.cgColor, borderRadius)
        errorLabel.isHidden = true
        errorLabel.text = nil
    }
}

enum EditState: Equatable {
    case empty
    case invalid
    case valid
}
