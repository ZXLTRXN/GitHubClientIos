//
//  UserInfo.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation

struct UserInfo: Codable {
    let login: String
    let id: Int
    let url: String
}
