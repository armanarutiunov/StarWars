//
//  FilmographyManagerTests.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

import Cloud
@testable import FilmographyManager
import XCTest

final class FilmographyManagerTests: XCTestCase {

    // MARK: - Film Fetching

    func testFetchFilmsSuccess() async throws {
        let expectedResponse = FilmsResponse(films: [.mock()])
        let cloudManager = MockCloudManager(expectedResult: .success(expectedResponse))
        let manager = FilmographyManager(cloudManager: cloudManager)

        let response = try await manager.fetchFilms()

        XCTAssertEqual(response, expectedResponse.films)
    }

    func testFetchRoomsFailure() async {
        let expectedError = NSError.unknown
        let cloudManager = MockCloudManager(expectedResult: .failure(expectedError))
        let manager = FilmographyManager(cloudManager: cloudManager)

        do {
            let _ = try await manager.fetchFilms()
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }

    // MARK: Characters Fetching

    func testCharactersSuccess() async throws {
        let singlePageCharacters: [Character] = [.mock(),
                                                 .mock(name: "Leia Organa"),
                                                 .mock(name: "Darth Vader")]
        let singlePageResponse = CharactersPage(nextPage: 2, characters: singlePageCharacters)
        let cloudManager = MockCloudManager(expectedResult: .success(singlePageResponse))
        let manager = FilmographyManager(cloudManager: cloudManager)

        let response = try await manager.fetchCharacters()

        // Because fetchCharacters() fetches characters from 9 pages, we need to mock that in the test
        var ninePageCharacters = [Character]()
        for _ in 1..<10 {
            ninePageCharacters.append(contentsOf: singlePageCharacters)
        }
        ninePageCharacters.sort()

        XCTAssertEqual(response, ninePageCharacters)
    }

    func testCharactersFailure() async {
        let expectedError = NSError.unknown
        let cloudManager = MockCloudManager(expectedResult: .failure(expectedError))
        let manager = FilmographyManager(cloudManager: cloudManager)

        do {
            let _ = try await manager.fetchCharacters()
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}
