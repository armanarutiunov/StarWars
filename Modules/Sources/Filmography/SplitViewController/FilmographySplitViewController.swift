//
//  FilmographySplitViewController.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import UIKit

public final class FilmographySplitViewController: UISplitViewController {

    // MARK: - Declarations

    private enum Constant {
        static let cornerRadius = 10.0
        static let length = 200.0
    }

    // MARK: - Properties

    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.hidesWhenStopped = true
        spinnerView.backgroundColor = UIColor.darkGray
        spinnerView.color = .white
        spinnerView.layer.cornerRadius = Constant.cornerRadius

        view.addSubview(spinnerView)

        spinnerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: Constant.length),
            spinnerView.widthAnchor.constraint(equalToConstant: Constant.length)
        ])

        return spinnerView
    }()

    private let dataSource = FilmographyDataSource()

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

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            UINavigationController(rootViewController: filmsViewController),
            UINavigationController(rootViewController: charactersViewController),
            UINavigationController(rootViewController: characterDetailsViewController)
        ]

        delegate = self
        preferredDisplayMode = .twoBesideSecondary

        update(with: .init(isDataReady: false))
        spinnerView.startAnimating()
    }

    // MARK: - Actions

    func update(with viewModel: FilmographyViewModel) {
        view.isUserInteractionEnabled = viewModel.isUserInteractionEnabled
        spinnerView.isHidden = viewModel.isSpinnerHidden
    }
}

// MARK: - UISplitViewControllerDelegate
extension FilmographySplitViewController: UISplitViewControllerDelegate {

    public func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        .primary
    }
}
