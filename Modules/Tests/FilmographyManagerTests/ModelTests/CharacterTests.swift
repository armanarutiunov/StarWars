//
//  CharacterTests.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

@testable import FilmographyManager
import Utilities
import XCTest

final class CharacterTests: XCTestCase {

    // MARK: - Decoding

    func testDecode() {
        let character: Character? = decodeFromJSON(json: CharacterJSON)

        XCTAssertNotNil(character, "Character failed to parse")
        XCTAssertEqual(character?.id, "1")
        XCTAssertEqual(character?.name, "Luke Skywalker")
        XCTAssertEqual(character?.height, "172")
        XCTAssertEqual(character?.mass, "77")
        XCTAssertEqual(character?.hairColor, "blond")
        XCTAssertEqual(character?.skinColor, "fair")
        XCTAssertEqual(character?.eyeColor, "blue")
        XCTAssertEqual(character?.birthYear, "19BBY")
        XCTAssertEqual(character?.gender, "male")
    }

    // MARK: - Encoding

    func testEncode() {
        let character = Character.mock()
        let characterJSON = encodeToJSON(object: character)

        XCTAssertNotNil(characterJSON)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.name.rawValue] as? String, character.name)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.height.rawValue] as? String, character.height)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.mass.rawValue] as? String, character.mass)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.hairColor.rawValue] as? String, character.hairColor)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.skinColor.rawValue] as? String, character.skinColor)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.eyeColor.rawValue] as? String, character.eyeColor)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.birthYear.rawValue] as? String, character.birthYear)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.gender.rawValue] as? String, character.gender)
        XCTAssertEqual(characterJSON?[Character.CodingKeys.url.rawValue] as? String, "https://swapi.dev/api/people/\(character.id)/")
    }
}
