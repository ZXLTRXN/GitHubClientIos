//
//  Repo.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import Foundation

struct Repo {
    let id: Int
    let owner: String
    let name: String
    let htmlUrl: String
    var languageColor: String
    var description: String? = nil
    var language: String? = nil
    var license: String? = nil
    var forks: Int = 0
    var stars: Int = 0
    var watchers: Int = 0
    var branch: String = "master"
}
