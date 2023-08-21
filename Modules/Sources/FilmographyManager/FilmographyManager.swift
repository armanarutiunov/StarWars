//
//  FilmographyManager.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Cloud
import Datastore
import Foundation
import Utilities

public protocol FilmographyManageable {
    var cachedFilms: [Film]? { get }
    var cachedCharacters: [Character]? { get }

    func fetchFilms() async throws -> [Film]
    func fetchCharacters() async throws -> [Character]
}

public final class FilmographyManager: FilmographyManageable {

    // MARK: - Declarations

    enum ParameterKey: String {
        case page
    }

    private enum DatastoreKey {
        static let films = "FilmographyManager.films"
        static let characters = "FilmographyManager.characters"
    }

    // MARK: - Properties

    public static let shared = FilmographyManager()

    private let cloudManager: CloudManageable

    public var cachedFilms: [Film]? {
        Datastore.load(key: DatastoreKey.films)
    }

    public var cachedCharacters: [Character]? {
        Datastore.load(key: DatastoreKey.characters)
    }

    // MARK: - Life Cycle

    public init(cloudManager: CloudManageable? = nil) {
        self.cloudManager = cloudManager ?? CloudManager.shared
    }

    // MARK: - Actions

    @MainActor
    public func fetchFilms() async throws -> [Film] {
        let configuration = RequestConfiguration(httpMethod: .get,
                                                 endpoint: SWAPIEndpoint.films,
                                                 httpHeaders: SWAPIHeader.allHeaders)
        let response: FilmsResponse = try await cloudManager.request(with: configuration)
        Datastore.save(response.films, key: DatastoreKey.films)
        return response.films
    }

    @MainActor
    public func fetchCharacters() async throws -> [Character] {
        try await withThrowingTaskGroup(of: CharactersPage.self) { taskGroup in
            for page in 1..<10 {
                taskGroup.addTask { [weak self] in
                    guard let self else {
                        throw NSError.unknown
                    }

                    return try await self.fetchCharactersPage(at: page)
                }
            }

            var characters = [Character]()

            for try await page in taskGroup {
                characters.append(contentsOf: page.characters)
            }

            let sortedCharacters = characters.sorted()
            Datastore.save(sortedCharacters, key: DatastoreKey.characters)

            return sortedCharacters
        }
    }

    private func fetchCharactersPage(at page: Int) async throws -> CharactersPage {
        try await cloudManager.request(with: .init(httpMethod: .get,
                                                   endpoint: SWAPIEndpoint.people,
                                                   parameters: [ParameterKey.page.rawValue: "\(page)"],
                                                   httpHeaders: SWAPIHeader.allHeaders))
    }
}
