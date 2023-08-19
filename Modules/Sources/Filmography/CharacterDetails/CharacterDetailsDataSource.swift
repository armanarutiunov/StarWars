//
//  CharacterDetailsDataSource.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

final class CharacterDetailsDataSource {

    // MARK: - Declarations

    enum Section {
        case main
    }

    // MARK: - Properties

    private let dataSource: UICollectionViewDiffableDataSource<Section, CharacterAttribute>

    // MARK: - Life Cycle

    init(collectionView: UICollectionView,
         cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, CharacterAttribute>) {
        self.dataSource = UICollectionViewDiffableDataSource<Section, CharacterAttribute>(collectionView: collectionView) { (collectionView, indexPath, item) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        configureDataSnapshot(with: [])
    }

    // MARK: - Actions

    func updateData(with character: Character) {
        let characterAttributes: [CharacterAttribute] = [
            .name(character.name),
            .height(character.height),
            .mass(character.mass),
            .hairColor(character.hairColor),
            .skinColor(character.skinColor),
            .eyeColor(character.eyeColor),
            .birthYear(character.birthYear),
            .gender(character.gender)
        ]

        configureDataSnapshot(with: characterAttributes)
    }

    private func configureDataSnapshot(with characterAttributes: [CharacterAttribute]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterAttribute>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characterAttributes)
        dataSource.apply(snapshot, animatingDifferences: !characterAttributes.isEmpty)
    }
}
