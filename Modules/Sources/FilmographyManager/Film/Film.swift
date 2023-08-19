//
//  Film.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation

public struct Film: Identifiable, Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case title
        case characterURLs = "characters"
        case url = "url"
    }

    // MARK: - Properties

    public let id: String

    public let title: String

    public let characterIDs: [String]

    // MARK: - Life Cycle

    init(id: String, title: String, characterIDs: [String]) {
        self.id = id
        self.title = title
        self.characterIDs = characterIDs
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(URL.self, forKey: .url).lastPathComponent
        self.title = try container.decode(String.self, forKey: .title)
        characterIDs = try container.decode([URL].self, forKey: .characterURLs)
            .map {
                $0.lastPathComponent
            }
    }
}

// MARK: - Hashable
extension Film: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(characterIDs)
    }
}
