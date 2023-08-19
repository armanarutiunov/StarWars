//
//  FilmsViewController.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import DesignSystem
import UIKit

final class FilmsViewController: UIViewController {

    // MARK: - Propreties

    private var filmsView: FilmsView {
        guard let view = view as? FilmsView else {
            fatalError("Failed to cast view to FilmsView")
        }
        return view
    }

    private var dataSource: FilmsDataSource!

    // MARK: - Life Cycle

    override func loadView() {
        view = FilmsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        filmsView.collectionView.delegate = self
        dataSource = FilmsDataSource(collectionView: filmsView.collectionView,
                                     cellRegistration: filmsView.cellRegistration)
        fetchFilms()
    }

    // MARK: - Actions

    private func fetchFilms() {
        Task { [weak self] in
            guard let self else {
                return
            }

            do {
                try await dataSource.fetchFilms()
            } catch {
                show(error as NSError)
            }

            filmsView.update(with: .init(isActivityIndicatorHidden: false))
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FilmsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
