//
//  AuthViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 17.06.2022.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func editingBegin(_ sender: UITextField) {
        setBorderColor(sender, UIColor(named: "customBlue")?.cgColor)
    }
    

    @IBAction func editingEnd(_ sender: UITextField) {
        removeBorder(sender)
    }
    
    private func setUI() {
        let placeholder = NSLocalizedString("TOKEN_PLACEHOLDER", comment: "")
        tokenTextField.placeholder = placeholder
        let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        tokenTextField.bounds.inset(by: padding)

        let signIn = NSLocalizedString("SIGN_IN_BUTTON", comment: "")
        signInButton.setTitle(signIn, for: .normal)
        signInButton.layer.cornerRadius = 8
        signInButton.clipsToBounds = true

    }
    
    private func setBorderColor(_ sender: UITextField, _ color: CGColor?) {
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = 8
        sender.layer.borderColor = color
    }
    
    private func removeBorder(_ sender: UITextField) {
        sender.layer.borderWidth = 0.0
        sender.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
    
    
}
