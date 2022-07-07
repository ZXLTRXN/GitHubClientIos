//
//  ColorManager.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 05.07.2022.
//

import UIKit

class ColorManager {
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
        let defaultLanguageColor: String = UIColor(named: "DefaultLanguage")!.toHex()!
        guard let language = language else { return defaultLanguageColor }
        return colors[language] ?? defaultLanguageColor
    }
}
