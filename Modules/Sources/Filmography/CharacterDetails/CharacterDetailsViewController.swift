//
//  CharacterDetailsViewController.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

final class CharacterDetailsViewController: UIViewController {

    // MARK: - Propreties

    private var characterDetailsView: CharacterDetailsView {
        guard let view = view as? CharacterDetailsView else {
            fatalError("Failed to cast view to CharacterDetailsView")
        }
        return view
    }

    private lazy var dataSource: CharacterDetailsDataSource = {
        CharacterDetailsDataSource(collectionView: characterDetailsView.collectionView,
                                   cellRegistration: characterDetailsView.cellRegistration)
    }()

    // MARK: - Life Cycle

    override func loadView() {
        view = CharacterDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Actions

    func update(with character: Character) {
        title = character.name
        dataSource.updateData(with: character)
    }
}
