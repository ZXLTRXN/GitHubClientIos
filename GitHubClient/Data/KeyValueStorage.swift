//
//  KeyValueStorage.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation

class KeyValueStorage {
    private static let AUTH_TOKEN_ARG_KEY = "authToken"
    
    private let storage: UserDefaults
    
    static let shared = KeyValueStorage()
    
    var authToken: String? {
        get {
            storage.string(forKey: KeyValueStorage.AUTH_TOKEN_ARG_KEY)
        }
        set(token) {
            storage.set(token, forKey: KeyValueStorage.AUTH_TOKEN_ARG_KEY)
        }
    }
    
    
    init() {
        storage = UserDefaults.standard
    }
}
