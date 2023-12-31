//
//  CharactersViewController.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import DesignSystem
import FilmographyManager
import UIKit

protocol CharactersViewControllerDelegate: AnyObject {
    func charactersViewControllerDidFetchCharacters()
    func charactersViewControllerDidSelectCharacter(_ character: Character)
}

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

    private lazy var dataSource: CharactersDataSource = {
        CharactersDataSource(collectionView: charactersView.collectionView,
                             cellRegistration: charactersView.cellRegistration)
    }()

    weak var delegate: CharactersViewControllerDelegate?

    // MARK: - Life Cycle

    override func loadView() {
        view = CharactersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constant.title
        navigationController?.navigationBar.prefersLargeTitles = true

        charactersView.collectionView.delegate = self
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
                delegate?.charactersViewControllerDidFetchCharacters()
            } catch {
                show(error as NSError)
            }
        }
    }

    func updateToCharacters(from film: Film) {
        dataSource.filterCharacters(with: film.characterIDs)
    }
}

// MARK: - UICollectionViewDelegate
extension CharactersViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        delegate?.charactersViewControllerDidSelectCharacter(character)
    }
}
