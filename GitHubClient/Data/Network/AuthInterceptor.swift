//
//  AuthInterceptor.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 27.06.2022.
//


import Alamofire

class AuthInterceptor: RequestInterceptor {
    
    let retryLimit = 3
    let retryDelay: TimeInterval = 5
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        if let token = KeyValueStorage.shared.authToken {
            urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        let response = request.task?.response as? HTTPURLResponse
        
        if let statusCode = response?.statusCode,
           (500...599).contains(statusCode),
           request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
            return completion(.doNotRetry)
        }
    }
}
