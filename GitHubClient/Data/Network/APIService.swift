//
//  APIService.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//

import Foundation
import Alamofire

class APIService {
    private static let BASE_URL = "https://api.github.com/"
    static let shared = APIService()
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
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
    
//    func getRepositoryReadme(ownerName: String, repoName: String, branch: String) {
//        
//    }
}


extension DataRequest {
    func map<D: Decodable>(to type: D.Type, completion: @escaping (D?, Error?) -> Void) {
        self.validate().responseData { data in
            switch data.result {
            case .success(let value):
                do {
                    let decodedData = try JSONDecoder().decode(type, from: value)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, error)
                }
                
            case .failure(let error):// не работает
                let nsError = (error as NSError)
                guard nsError.domain != NSURLErrorDomain,
                      nsError.code != NSURLErrorTimedOut,
                      nsError.code != NSURLErrorNotConnectedToInternet else {
                    completion(nil, RequestError.noInternet)
                    return
                }
                guard let code = data.response?.statusCode else {
                    completion(nil, error) // неверно
                    return
                }
                
                switch code {
                case 401:
                    completion(nil, RequestError.wrongToken)
                case 403:
                    completion(nil, RequestError.noRights)
                default:
                    completion(nil, RequestError.unknown(code: code))
                }
            }
        }
    }
}
