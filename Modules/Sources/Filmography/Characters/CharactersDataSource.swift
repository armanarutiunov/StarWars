//
//  CharactersDataSource.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

final class CharactersDataSource {

    // MARK: - Declarations

    enum Section {
        case main
    }

    // MARK: - Properties

    private let manager: FilmographyManageable

    private let dataSource: UICollectionViewDiffableDataSource<Section, Character>

    private var characters = [Character]()

    private var deferredCharacterFilter = [String]()

    // MARK: - Life Cycle

    init(manager: FilmographyManageable? = nil,
         collectionView: UICollectionView,
         cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Character>) {
        self.manager = manager ?? FilmographyManager.shared
        self.dataSource = UICollectionViewDiffableDataSource<Section, Character>(collectionView: collectionView) { (collectionView, indexPath, item) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        configureDataSnapshot(with: characters, animatingDifferences: false)
    }

    // MARK: - Actions

    @MainActor
    func fetchCharacters() async throws {
        if let cachedCharacters = manager.cachedCharacters {
            self.characters = cachedCharacters
            configureDataSnapshot(with: characters)
            return
        }

        do {
            self.characters = try await manager.fetchCharacters()
            configureDataSnapshot(with: characters)
            if !deferredCharacterFilter.isEmpty {
                filterCharacters(with: deferredCharacterFilter)
            }
        } catch {
            throw error
        }
    }

    func filterCharacters(with ids: [String]) {
        guard !characters.isEmpty else {
            deferredCharacterFilter = ids
            return
        }

        let characters = characters
            .filter { ids.contains($0.id) }

        configureDataSnapshot(with: characters)
    }

    private func configureDataSnapshot(with characters: [Character], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func itemIdentifier(for indexPath: IndexPath) -> Character? {
        dataSource.itemIdentifier(for: indexPath)
    }
}
