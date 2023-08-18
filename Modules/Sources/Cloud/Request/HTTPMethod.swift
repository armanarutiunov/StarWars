//
//  HTTPMethod.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

public enum HTTPMethod {
    case get
    case post
    case put
    case delete
}

// MARK: - CustomStringConvertible
extension HTTPMethod: CustomStringConvertible {

    public var description: String {
        switch self {
        case .get:
            return "GET"

        case .post:
            return "POST"

        case .put:
            return "PUT"

        case .delete:
            return "DELETE"
        }
    }
}

// MARK: - Equatable
extension HTTPMethod: Equatable {

    public static func == (lhs: HTTPMethod, rhs: HTTPMethod) -> Bool {
        switch (lhs, rhs) {
        case (.get, .get),
            (.post, .post),
            (.put, .put),
            (.delete, .delete):
            return true

        default:
            return false
        }
    }
}
