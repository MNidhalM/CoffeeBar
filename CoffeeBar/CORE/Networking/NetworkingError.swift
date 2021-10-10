//
//  NetworkingError.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation

public struct NetworkingError: Error {
    public enum Status: Int {
        case unknown = -1
        case networkUnreachable = 0
        case unableToParseResponse = 1
        case unableToParseRequest = 2
        case missingData = 3
    }
    
    public var status: Status

    public init(status: Status) {
        self.status = status
    }
    
    public init(error: Error) {
        if let networkingError = error as? NetworkingError {
            status = networkingError.status
        } else {
            if let theError = error as? URLError {
                status = Status(rawValue: theError.errorCode) ?? .unknown
            } else {
                status = .unknown
            }
        }
    }

}

extension NetworkingError {
    static var unableToParseResponse: NetworkingError {
        return NetworkingError(status: .unableToParseResponse)
    }

    static var unableToParseRequest: NetworkingError {
        return NetworkingError(status: .unableToParseRequest)
    }

    static var unknownError: NetworkingError {
        return NetworkingError(status: .unknown)
    }

    static var missingData: NetworkingError {
        return NetworkingError(status: .missingData)
    }

    static var networkUnreachable: NetworkingError {
        return NetworkingError(status: .networkUnreachable)
    }

}

extension NetworkingError: CustomStringConvertible {
    public var description: String {
        return String(describing: status)
            .replacingOccurrences(of: "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])",
                                  with: " ",
                                  options: [.regularExpression])
            .capitalized
    }
}
