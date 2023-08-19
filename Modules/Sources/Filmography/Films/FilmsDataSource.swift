//
//  FilmsDataSource.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

struct FilmsDataSource {

    // MARK: - Declarations

    enum Section {
        case main
    }

    // MARK: - Properties

    private let manager: FilmographyManageable

    private let dataSource: UICollectionViewDiffableDataSource<Section, Film>

    // MARK: - Life Cycle

    init(manager: FilmographyManageable? = nil,
         collectionView: UICollectionView,
         cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Film>) {
        self.manager = manager ?? FilmographyManager.shared
        self.dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: collectionView) { (collectionView, indexPath, item) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        configureDataSnapshot(with: [])
    }

    // MARK: - Actions

    func fetchFilms() async throws {
        do {
            let films = try await manager.fetchFilms()
            configureDataSnapshot(with: films)
        } catch {
            throw error
        }
    }

    private func configureDataSnapshot(with films: [Film]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Film>()
        snapshot.appendSections([.main])
        snapshot.appendItems(films)
        dataSource.apply(snapshot, animatingDifferences: !films.isEmpty)
    }
}
