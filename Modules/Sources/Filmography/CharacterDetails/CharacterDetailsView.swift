//
//  CharacterDetailsView.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

final class CharacterDetailsView: UIView {

    // MARK: - Declaration

    private enum Constant {
        static let placeholderText = "⬅️ Select any character"
    }

    // MARK: - Properties

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(collectionView)
        return collectionView
    }()

    lazy var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, CharacterAttribute> = {
        .init { cell, indexPath, characterAttribute in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = characterAttribute.title
            contentConfiguration.secondaryText = characterAttribute.value
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
        }
    }()

    private let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = Constant.placeholderText
        return label
    }()

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        addSubviewsAndConstraints()
    }

    private func addSubviewsAndConstraints() {
        addSubview(placeholderLabel)

        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Actions

    func update(with viewModel: CharacterDetailsViewModel) {
        placeholderLabel.isHidden = viewModel.isPlaceholderLabelHidden
        collectionView.isHidden = viewModel.isCollectionViewHidden
    }
}
