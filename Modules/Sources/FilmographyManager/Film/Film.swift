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

// MARK: - Encodable
extension Film: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(title, forKey: .title)

        let url = URL(string: "https://swapi.dev/api/films/\(id)/")
        try container.encode(url, forKey: .url)

        let characterURLs = characterIDs.map {
            URL(string: "https://swapi.dev/api/people/\($0)/")
        }
        try container.encode(characterURLs, forKey: .characterURLs)
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

// MARK: - Mock
extension Film {

    static func mock(id: String = "2",
                     title: String = "The Empire Strikes Back",
                     characterIDs: [String] = ["1",
                                               "2",
                                               "3",
                                               "4",
                                               "5",
                                               "10",
                                               "13",
                                               "14",
                                               "18",
                                               "20",
                                               "21",
                                               "22",
                                               "23",
                                               "24",
                                               "25",
                                               "26"]) -> Film {
        Film(id: id,
             title: title,
             characterIDs: characterIDs)
    }
}
