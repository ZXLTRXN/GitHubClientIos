//
//  ErrorExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 01.07.2022.
//

import Foundation

extension Error {
    func toRequestError(statusCode: Int?) -> RequestError {
        
        guard Connectivity.isConnectedToInternet else { return RequestError.noInternet }
                
        switch statusCode {
        case 401:
            return RequestError.wrongToken
        case 403:
            return RequestError.noRights
        default:
            return RequestError.unknown(statusCode: statusCode)
        }
    }
}

