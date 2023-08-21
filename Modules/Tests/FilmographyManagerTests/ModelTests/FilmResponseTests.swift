//
//  FilmResponseTests.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

@testable import FilmographyManager
import Utilities
import XCTest

final class FilmResponseTests: XCTestCase {

    func testDecode() {
        let filmResponse: FilmsResponse? = decodeFromJSON(json: FilmsResponseJSON)
        let expectedFilm = Film(id: "2",
                                title: "The Empire Strikes Back",
                                characterIDs: ["1",
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
                                               "26"])

        XCTAssertNotNil(filmResponse, "Failed to parse FilmsResponse")
        XCTAssertEqual(filmResponse?.films, [expectedFilm])
    }
}
