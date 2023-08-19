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
        URL(string: "https://swapi.dev/")!
    }

    public var path: String {
        switch self {
        case .films:
            return "/api/films"

        case .people:
            return "/api/people"
        }
    }
}

