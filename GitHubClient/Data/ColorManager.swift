//
//  ColorManager.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 05.07.2022.
//

import Foundation
import UIKit

class ColorManager {
    private static let defaultColor: String = "#FFFFFF"
    private let colors: [String: String]
    
    static let shared = ColorManager()
    
    init() {
        guard let asset = NSDataAsset(name: "github_colors") else {
            fatalError("Missing data asset: github_colors")
        }
        let data = asset.data
        colors = try! JSONDecoder().decode([String: String].self, from: data)
    }
    
    func getColor(for language: String?) -> String {
        guard let language = language else { return ColorManager.defaultColor }
        return colors[language] ?? ColorManager.defaultColor
    }
}
