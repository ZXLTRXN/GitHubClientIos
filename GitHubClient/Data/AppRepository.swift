//
//  AppRepository.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation

class AppRepository {
    private let api = APIService.shared
    private let storage = KeyValueStorage.shared
    static let shared = AppRepository()
    
    func getRepositories(completion: @escaping (Array<Repo>?, Error?) -> Void) {
        api.getRepositories().map(to: Array<RepoNetwork>.self) {(reposNetwork, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let reposNetwork = reposNetwork, !reposNetwork.isEmpty else {
                completion(nil, RequestError.noRepositories)
                return
            }
            
            let repos = reposNetwork.map{ $0.toRepo()}
            completion(repos, nil)
        }
    }
    
    func getRepository(owner: String, repoName: String, completion: @escaping (Repo?, Error?) -> Void) {
        api.getRepository(owner: owner, repoName: repoName).map(to: RepoNetwork.self){ (repoNetwork, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(repoNetwork!.toRepo(), nil)
        }
    }
    
    func getRepositoryReadme(owner: String, repoName: String, branch: String, completion: @escaping (String?, Error?) -> Void) {
        api.getRepositoryReadme(owner: owner, repoName: repoName, branch: branch).map(to: String.self) { (readme, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(readme, nil)
        }
    }
    
    func signIn(token: String, completion: @escaping (Error?) -> Void) {
        api.getUser(token: token).map(to: UserInfo.self) {(_, error) in
            if error == nil {
                self.storage.authToken = token
            }
            completion(error)
        }
    }
    
    func signOut() {
        storage.authToken = nil
    }
}


