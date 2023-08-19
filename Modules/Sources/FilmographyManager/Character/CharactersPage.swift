//
//  CharactersPage.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import Foundation

struct CharactersPage: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case nextPageURL = "next"
        case characters = "results"
    }

    // MARK: - Properties

    let nextPage: Int?

    let characters: [Character]

    // MARK: - Life Cycle

    init(nextPage: Int?, characters: [Character]) {
        self.nextPage = nextPage
        self.characters = characters
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nextPageURLString = try? container.decode(String.self, forKey: .nextPageURL)
        let lastCharacter = nextPageURLString?.last ?? String.Element("")
        self.nextPage = Int("\(lastCharacter)")
        self.characters = try container.decode([Character].self, forKey: .characters)
    }
}
