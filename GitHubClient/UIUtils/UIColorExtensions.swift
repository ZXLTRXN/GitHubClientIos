//
//  UIColorExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    self.init(
                        red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
                    return
                }
            }
        }
        return nil
    }
}
