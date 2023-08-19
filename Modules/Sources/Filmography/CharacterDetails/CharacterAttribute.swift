//
//  CharacterAttribute.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager

enum CharacterAttribute: Hashable {
    case name(String)
    case height(String)
    case mass(String)
    case hairColor(String)
    case skinColor(String)
    case eyeColor(String)
    case birthYear(String)
    case gender(String)

    var title: String {
        switch self {
        case .name:
            return "Name"

        case .height:
            return "Height"

        case .mass:
            return "Mass"

        case .hairColor:
            return "Hair Color"

        case .skinColor:
            return "Skin Color"

        case .eyeColor:
            return "Eye Color"

        case .birthYear:
            return "Birth Year"

        case .gender:
            return "Gender"
        }
    }

    var value: String {
        switch self {
        case .name(let value),
                .height(let value),
                .mass(let value),
                .hairColor(let value),
                .skinColor(let value),
                .eyeColor(let value),
                .birthYear(let value),
                .gender(let value):
            return value
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(value)
    }
}
