//
//  RequestConfiguration.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation

public struct RequestConfiguration {

    // MARK: - Declarations

    private struct Constant {
        static let defaultTimeoutInterval: TimeInterval = 15
    }

    // MARK: - Properties

    let id: UUID

    let httpMethod: HTTPMethod

    let endpoint: Endpoint

    let parameters: [String: String]?

    let bodyData: Data?

    let httpHeader: [String: String]

    private var queryItems: [URLQueryItem]? {
        parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.baseURL.scheme
        urlComponents.host = endpoint.baseURL.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = queryItems
        return urlComponents
    }

    private var url: URL {
        guard let url = urlComponents.url else {
            fatalError("Failed to construct a URL from base URL: '\(endpoint.baseURL)', path: '\(endpoint.path)' and query items: '\(urlComponents.queryItems ?? [])'")
        }
        return url
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: url, timeoutInterval: Constant.defaultTimeoutInterval)
        request.httpBody = bodyData
        request.httpMethod = httpMethod.description
        request.allHTTPHeaderFields = httpHeader
        return request
    }

    // MARK: - Life Cycle

    public init(id: UUID = UUID(),
                httpMethod: HTTPMethod,
                endpoint: Endpoint,
                parameters: [String: String]? = nil,
                bodyData: Data? = nil,
                httpHeaders: [String: String]) {
        self.id = id
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.parameters = parameters
        self.bodyData = bodyData
        self.httpHeader = httpHeaders
    }
}

// MARK: - Equatable
extension RequestConfiguration: Equatable {

    public static func == (lhs: RequestConfiguration, rhs: RequestConfiguration) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - CustomStringConvertible
extension RequestConfiguration: CustomStringConvertible {

    public var description: String {
        "\(httpMethod.description) \(endpoint.url)"
    }
}
