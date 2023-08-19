//
//  CharactersViewController.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import DesignSystem
import UIKit

final class CharactersViewController: UIViewController {

    // MARK: - Declarations

    private enum Constant {
        static let title = "Characters"
    }

    // MARK: - Propreties

    private var charactersView: CharactersView {
        guard let view = view as? CharactersView else {
            fatalError("Failed to cast view to CharactersView")
        }
        return view
    }

    private var dataSource: CharactersDataSource!

    // MARK: - Life Cycle

    override func loadView() {
        view = CharactersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constant.title
        navigationController?.navigationBar.prefersLargeTitles = true

        charactersView.collectionView.delegate = self
        dataSource = CharactersDataSource(collectionView: charactersView.collectionView,
                                          cellRegistration: charactersView.cellRegistration)
        fetchCharacters()
    }

    // MARK: - Actions

    private func fetchCharacters() {
        Task { [weak self] in
            guard let self else {
                return
            }

            do {
                try await dataSource.fetchCharacters()
            } catch {
                show(error as NSError)
            }

            charactersView.update(with: .init(isActivityIndicatorHidden: false))
        }
    }
}

// MARK: - UICollectionViewDelegate
extension CharactersViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
