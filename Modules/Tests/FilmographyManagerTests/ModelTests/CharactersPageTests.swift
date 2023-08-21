//
//  CharactersPageTests.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

@testable import FilmographyManager
import Utilities
import XCTest

final class CharactersPageTests: XCTestCase {

    func testDecode() {
        let charactersPage: CharactersPage? = decodeFromJSON(json: CharactersPageJSON)
        let expectedCharacter = Character(id: "1",
                                          name: "Luke Skywalker",
                                          height: "172",
                                          mass: "77",
                                          hairColor: "blond",
                                          skinColor: "fair",
                                          eyeColor: "blue",
                                          birthYear: "19BBY",
                                          gender: "male")

        XCTAssertNotNil(charactersPage)
        XCTAssertEqual(charactersPage?.nextPage, 2)
        XCTAssertEqual(charactersPage?.characters, [expectedCharacter])
    }
}
