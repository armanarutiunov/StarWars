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
        case id = "episode_id"
        case title
        case characterURLs = "characters"
    }

    // MARK: - Properties

    public let id: Int

    public let title: String

    public let characterIDs: [String]

    // MARK: - Life Cycle

    init(id: Int, title: String, characterIDs: [String]) {
        self.id = id
        self.title = title
        self.characterIDs = characterIDs
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
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
