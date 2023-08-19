//
//  FilmsView.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

final class FilmsView: UIView {

    // MARK: - Properties

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(collectionView)
        return collectionView
    }()

    lazy var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Film> = {
        .init { cell, indexPath, film in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = film.title
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.listSidebarCell()
        }
    }()

    private let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .sidebarPlain))

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        return activityIndicator
    }()

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        addSubviewsAndConstraints()
    }

    private func addSubviewsAndConstraints() {
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Actions

    func update(with viewModel: FilmsViewModel) {
        activityIndicator.isHidden = viewModel.isActivityIndicatorHidden
    }
}
