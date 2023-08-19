//
//  FilmographySplitViewController.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import UIKit

public final class FilmographySplitViewController: UISplitViewController {

    // MARK: - Properties

    private let filmsViewController = FilmsViewController()

    private let charactersViewController = CharactersViewController()

    private let characterDetailsViewController = CharacterDetailsViewController()

    // MARK: - Life Cycle

    public init() {
        super.init(style: .tripleColumn)

        viewControllers = [
            UINavigationController(rootViewController: filmsViewController),
            UINavigationController(rootViewController: charactersViewController),
            UINavigationController(rootViewController: characterDetailsViewController)
        ]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
