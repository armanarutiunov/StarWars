//
//  FilmTests.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

@testable import FilmographyManager
import Utilities
import XCTest

final class FilmTests: XCTestCase {

    func testDecode() {
        let film: Film? = decodeFromJSON(json: FilmJSON)

        XCTAssertNotNil(film, "Failed to parse Film")
        XCTAssertEqual(film?.id, "2")
        XCTAssertEqual(film?.title, "The Empire Strikes Back")
        XCTAssertEqual(film?.characterIDs, ["1",
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
    }
}
