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
    let description: String? = nil
    let language: String? = nil
    let license: String? = nil
    let languageColor: String? = nil
    let forks: Int = 0
    let stars: Int = 0
    let watchers: Int = 0
    let branch: String = "master"
}
