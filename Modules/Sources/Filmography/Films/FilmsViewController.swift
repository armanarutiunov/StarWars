//
//  FilmsViewController.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import DesignSystem
import UIKit

final class FilmsViewController: UIViewController {

    // MARK: - Declarations

    private enum Constant {
        static let title = "Films"
    }

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

        title = Constant.title
        navigationController?.navigationBar.prefersLargeTitles = true

        filmsView.collectionView.delegate = self
        dataSource = FilmsDataSource(collectionView: filmsView.collectionView,
                                     cellRegistration: filmsView.cellRegistration)
        fetchFilms()
    }

    // MARK: - Actions

    @MainActor
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
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FilmsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
