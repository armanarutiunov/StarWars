//
//  FilmographyManager.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Cloud

public protocol FilmographyManageable {
    func fetchFilms() async throws -> [Film]
}

public final class FilmographyManager: FilmographyManageable {

    // MARK: - Declarations

    enum ParameterKey: String {
        case page
    }

    // MARK: - Properties

    public static let shared = FilmographyManager()

    private let cloudManager: CloudManageable

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
        return response.films
    }

    public func fetchCharacters() async throws -> [Character] {
        var index: Int?
        var characters = [Character]()

        while index != nil {
            let page = try await fetchCharactersPage(at: index ?? 1)
            index = page.nextPage
            characters.append(contentsOf: page.characters)
        }

        return characters
    }

    private func fetchCharactersPage(at index: Int) async throws -> CharactersPage {
        try await cloudManager.request(with: .init(httpMethod: .get,
                                                   endpoint: SWAPIEndpoint.people,
                                                   parameters: [ParameterKey.page.rawValue: "\(index)"],
                                                   httpHeaders: SWAPIHeader.allHeaders))
    }
}
