//
//  AppRepository.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//



class AppRepository {
    private let api = APIService.shared
    private let storage = KeyValueStorage.shared
    static let shared = AppRepository()
    
    func getRepositories(completion: @escaping (Array<Repo>?, RequestError?) -> Void) {
        api.getRepositories().mapJSON(to: Array<RepoNetwork>.self) {(reposNetwork, error) in
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
    
    func getRepository(owner: String, repoName: String, completion: @escaping (Repo?, RequestError?) -> Void) {
        api.getRepository(owner: owner, repoName: repoName).mapJSON(to: RepoNetwork.self){ (repoNetwork, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(repoNetwork!.toRepo(), nil)
        }
    }
    
    func getRepositoryReadme(owner: String, repoName: String, branch: String, completion: @escaping (String?, RequestError?) -> Void) {
        api.getRepositoryReadme(owner: owner, repoName: repoName, branch: branch).mapString() { (readme, error) in
            guard error == nil else {
                if case .unknown(let statusCode) = error {
                    if statusCode == APIService.NOT_FOUND_CODE {
                        completion(nil, RequestError.readmeNotFound)
                        return
                    }
                }
                completion(nil, error)
                return
            }
            completion(readme, nil)
        }
    }
    
    func signIn(token: String, completion: @escaping (RequestError?) -> Void) {
        api.getUser(token: token).mapJSON(to: UserInfo.self) {(_, error) in
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


