//
//  ErrorExtensions.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 01.07.2022.
//

extension Error {
    func toRequestError(statusCode: Int?) -> RequestError {
        
        guard Connectivity.isConnectedToInternet else { return RequestError.noInternet }
        
        switch statusCode {
        case APIService.WRONG_TOKEN_CODE:
            return RequestError.wrongToken
        case APIService.NO_RIGHTS_CODE:
            return RequestError.noRights
        default:
            return RequestError.unknown(statusCode: statusCode)
        }
    }
}

