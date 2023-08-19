//
//  FilmographySplitViewController.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import UIKit

public final class FilmographySplitViewController: UISplitViewController {

    // MARK: - Properties

    private var filmographyView: FilmographyView {
        guard let view = view as? FilmographyView else {
            fatalError("Failed to cast view to FilmographyView")
        }
        return view
    }

    private let filmsViewController = FilmsViewController()

    private let charactersViewController = CharactersViewController()

    private let characterDetailsViewController = CharacterDetailsViewController()

    // MARK: - Life Cycle

    public init() {
        super.init(style: .tripleColumn)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = FilmographyView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            UINavigationController(rootViewController: filmsViewController),
            UINavigationController(rootViewController: charactersViewController),
            UINavigationController(rootViewController: characterDetailsViewController)
        ]

        delegate = self
        preferredDisplayMode = .twoBesideSecondary

        filmographyView.update(with: .init(isDataReady: false))
        filmographyView.spinnerView.startAnimating()
    }
}

// MARK: - UISplitViewControllerDelegate
extension FilmographySplitViewController: UISplitViewControllerDelegate {

    public func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        .primary
    }
}
