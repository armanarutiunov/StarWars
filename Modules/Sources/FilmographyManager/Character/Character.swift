//
//  Character.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation

public struct Character: Identifiable, Decodable {

    // MARK: Declarations

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case url
    }

    // MARK: - Properties

    public let id: String

    public let name: String

    public let height: String

    public let mass: String

    public let hairColor: String

    public let skinColor: String

    public let eyeColor: String

    public let birthYear: String

    public let gender: String

    // MARK: - Life Cycle

    init(id: String, name: String, height: String, mass: String, hairColor: String, skinColor: String, eyeColor: String, birthYear: String, gender: String) {
        self.id = id
        self.name = name
        self.height = height
        self.mass = mass
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.eyeColor = eyeColor
        self.birthYear = birthYear
        self.gender = gender
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(URL.self, forKey: .url).lastPathComponent
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(String.self, forKey: .height)
        self.mass = try container.decode(String.self, forKey: .mass)
        self.hairColor = try container.decode(String.self, forKey: .hairColor)
        self.skinColor = try container.decode(String.self, forKey: .skinColor)
        self.eyeColor = try container.decode(String.self, forKey: .eyeColor)
        self.birthYear = try container.decode(String.self, forKey: .birthYear)
        self.gender = try container.decode(String.self, forKey: .gender)
    }
}

// MARK: - Hashable
extension Character: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(height)
        hasher.combine(mass)
        hasher.combine(hairColor)
        hasher.combine(skinColor)
        hasher.combine(eyeColor)
        hasher.combine(birthYear)
        hasher.combine(gender)
    }
}
