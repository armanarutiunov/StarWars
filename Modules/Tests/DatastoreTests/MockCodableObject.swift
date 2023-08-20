//
//  MockCodableObject.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

import Foundation

struct MockCodableObject: Codable, Equatable {

    // MARK: - Properties

    let id: String
    let value: String

    // MARK: Life Cycle

    init(id: String, value: String) {
        self.id = id
        self.value = value
    }
}
