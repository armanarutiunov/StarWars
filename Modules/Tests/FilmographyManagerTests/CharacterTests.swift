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
}
