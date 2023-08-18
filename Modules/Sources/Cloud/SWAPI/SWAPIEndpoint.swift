//
//  SWAPIEndpoint.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation

public enum SWAPIEndpoint: Endpoint {
    case films
    case people

    public var baseURL: URL {
        URL(string: "https://swapi.dev/api")!
    }

    public var path: String {
        switch self {
        case .films:
            return "/films"

        case .people:
            return "/people"
        }
    }
}

