//
//  Errors.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 24.06.2022.
//

import Foundation
import UIKit

enum RequestError: Error {
    case noInternet
    case wrongToken
    case noRights
    case readmeNotFound
    case noRepositories
    case unknown(statusCode: Int?)
}

extension RequestError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("errorType.connectionError.description", comment: "")
        case .wrongToken:
            return NSLocalizedString("errorType.wrongToken.description", comment: "")
        case .noRights:
            return NSLocalizedString("errorType.noRights.description", comment: "")
        case .readmeNotFound:
            return NSLocalizedString("errorType.readmeNotFound.description", comment: "")
        case .noRepositories:
            return NSLocalizedString("errorType.noRepositories.description", comment: "")
        case .unknown:
            return NSLocalizedString("errorType.unknownError.description", comment: "")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .unknown(let statusCode):
            var codeString: String = "null"
            if let statusCode = statusCode {
                codeString = "\(statusCode)"
            }
            let str = String(
                format: NSLocalizedString("errorType.unknownError.failureReason", comment: ""),
                "\(self.localizedDescription)",
                codeString
            )
            print(str)
            return str
        default:
            return nil
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("errorType.connectionError.suggestion", comment: "")
        case .wrongToken:
            return NSLocalizedString("errorType.wrongToken.suggestion", comment: "")
        case .noRights:
            return NSLocalizedString("errorType.noRights.suggestion", comment: "")
        case .readmeNotFound:
            return NSLocalizedString("errorType.readmeNotFound.suggestion", comment: "")
        case .noRepositories:
            return NSLocalizedString("errorType.noRepositories.suggestion", comment: "")
        case .unknown:
            return NSLocalizedString("errorType.unknownError.suggestion", comment: "")
        }
    }
}
