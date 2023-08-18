//
//  Endpoint.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var baseURL: URL { get }
}

extension Endpoint {

    var url: URL {
        URL(string: path, relativeTo: baseURL)!
    }
}
