//
//  AuthViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 17.06.2022.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    let activityIndicator = MDCActivityIndicator()
    
    let borderRadius: CGFloat = 8
    var editState: EditState = .valid
    var validationEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenTextField.delegate = self
        setUI()
    }
    
    private func setUI() {
        let placeholder = NSLocalizedString("TOKEN_PLACEHOLDER", comment: "")
        tokenTextField.placeholder = placeholder

        let signIn = NSLocalizedString("SIGN_IN_BUTTON", comment: "")
        signInButton.setTitle(signIn, for: .normal)
        signInButton.layer.cornerRadius = borderRadius
        signInButton.clipsToBounds = true
        
        activityIndicator.sizeToFit()
        activityIndicator.tintColor = UIColor(named: "DefaultBlue")
        view.addSubview(activityIndicator)
    }
    
    
    @IBAction func signInTapped(_ sender: UIButton) {
        onLoading(started: true)
        if !validationEnabled {
            validationEnabled = true
            checkValidation(onValid: setIdleState)
        }
        if editState == .valid {
//            appRepository.signIn(tokenTextField.text){
//
//            }
        }
        onLoading(started: false)
    }
    
    func onLoading(started flag: Bool) {
        tokenTextField.isEnabled = !flag
        signInButton.isEnabled = !flag
        if flag {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    
    // MARK: textField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkValidation(onValid: setIdleState)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidation(){
            removeBorder(textField)
        }
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        checkValidation(onValid: setIdleState)
    }
    //
    
    private func checkValidation(onValid: () -> Void) {
        if validationEnabled {
            editState = validateToken(tokenTextField.text)
            switch (editState) {
            case .invalid:
                setTokenErrorState(message: NSLocalizedString("INVALID_TOKEN", comment: ""))
            case .empty:
                setTokenErrorState(message: NSLocalizedString("EMPTY_TOKEN", comment: ""))
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
        setBorderColor(tokenTextField, redColor?.cgColor)
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    private func setIdleState() {
        setBorderColor(tokenTextField, UIColor(named: "DefaultBlue")?.cgColor)
        errorLabel.isHidden = true
        errorLabel.text = nil
    }
    
    private func setBorderColor(_ sender: UITextField, _ color: CGColor?) {
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = borderRadius
        sender.layer.borderColor = color
    }
    
    private func removeBorder(_ sender: UITextField) {
        sender.layer.borderWidth = 0.0
        sender.layer.cornerRadius = 0.0
        sender.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
    
}

enum EditState: Equatable {
    case empty
    case invalid
    case valid
}
