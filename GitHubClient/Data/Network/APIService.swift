//
//  APIService.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//


import Alamofire

class APIService {
    private static let BASE_URL = "https://api.github.com/"
    private static let README_BASE_URL = "https://raw.githubusercontent.com/"
    
    static let WRONG_TOKEN_CODE = 401
    static let NO_RIGHTS_CODE = 403
    static let NOT_FOUND_CODE = 404
    
    static let shared = APIService()
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 7
        configuration.headers.add(HTTPHeader(name: "Accept", value: "application/vnd.github.v3+json"))
        return Session(configuration: configuration, interceptor: AuthInterceptor())
    }()
    
    func getUser(token: String) -> DataRequest {
        sessionManager.request(APIService.BASE_URL + "user", headers: ["Authorization" : "token \(token)"])
    }
    
    func getRepositories() -> DataRequest {
        sessionManager.request(APIService.BASE_URL + "user/repos")
    }
    
    func getRepository(owner: String, repoName: String) -> DataRequest {
        sessionManager.request(APIService.BASE_URL + "repos/\(owner)/\(repoName)")
    }
    
    func getRepositoryReadme(owner: String, repoName: String, branch: String) -> DataRequest {
        sessionManager.request(APIService.README_BASE_URL + "\(owner)/\(repoName)/\(branch)/README.md")
    }
}

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
