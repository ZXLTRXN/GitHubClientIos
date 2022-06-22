//
//  TextFieldExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 22.06.2022.
//

import UIKit

extension UITextField {
    func setBorderColor(_ color: CGColor?,_ borderRadius: CGFloat) {
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = borderRadius
            self.layer.borderColor = color
        }
        
        func removeBorder() {
            self.layer.borderWidth = 0.0
            self.layer.cornerRadius = 0.0
            self.layer.borderColor = UIColor.opaqueSeparator.cgColor
        }
}
