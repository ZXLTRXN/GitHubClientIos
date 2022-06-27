//
//  RepoNetwork.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import Foundation

struct RepoNetwork: Codable {
    let id: Int
    let name: String
    let owner: Owner
    let htmlUrl: String
    let description: String? = nil
    let language: String? = nil
    let license: License? = nil
    let forks: Int = 0
    let stars: Int = 0
    let watchers: Int = 0
    let branch: String = "master"
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlUrl = "html_url"
        case description
        case language
        case license
        case forks = "forks_count"
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case branch = "default_branch"
    }
}

struct Owner: Codable {
    let login: String
}

struct License: Codable {
    let name: String
}

extension RepoNetwork {
    func toRepo() -> Repo {
        Repo(id: id, owner: owner.login, name: name, htmlUrl: htmlUrl,
             description: description, language: language, license: license?.name,
             languageColor: "#FFFFFF", forks: forks, stars: stars,
             watchers: watchers, branch: branch)
    }
}
