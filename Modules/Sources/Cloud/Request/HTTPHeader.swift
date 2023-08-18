//
//  HTTPHeader.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

public protocol HTTPHeader: CaseIterable {
    var key: String { get }
    var value: String { get }
}

// MARK: - All Headers
extension HTTPHeader {

    public static var allHeaders: [String: String] {
        var headers = [String: String]()
        allCases.forEach { headers[$0.key] = $0.value }
        return headers
    }
}
