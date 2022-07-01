//
//  DataRequestExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 01.07.2022.
//

import Alamofire


extension DataRequest {
    func mapJSON<D: Decodable>(to type: D.Type, completion: @escaping (D?, Error?) -> Void) {
        self.validate().responseData { data in
            switch data.result {
            case .success(let value):
                do {
                    let decodedData = try JSONDecoder().decode(type, from: value)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, error.toRequestError(statusCode: nil))
                }
            case .failure(let error):
                completion(nil, error.toRequestError(statusCode: data.response?.statusCode))
            }
        }
    }
    
    func mapString(completion: @escaping (String?, Error?) -> Void) {
        self.validate().responseData { data in
            switch data.result {
            case .success(let value):
                let str = String(decoding: value, as: UTF8.self)
                completion(str, nil)
            case .failure(let error):
                completion(nil, error.toRequestError(statusCode: data.response?.statusCode))
            }
        }
    }
}
