//
//  FilmsResponse.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation

struct FilmsResponse: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case films = "results"
    }

    // MARK: - Properties

    let films: [Film]
}
