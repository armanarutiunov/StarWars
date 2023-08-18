//
//  SWAPIHeader.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

public enum SWAPIHeader: String, HTTPHeader {
    case contentType = "Content-Type"

    public var key: String {
        return rawValue
    }

    public var value: String {
        switch self {
        case .contentType:
            return "application/json"
        }
    }
}
