//
//  FilmographyView.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import UIKit

final class FilmographyView: UIView {

    // MARK: - Declarations

    private enum Constant {
        static let cornerRadius = 10.0
        static let length = 200.0
    }

    // MARK: - Properties

    lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.hidesWhenStopped = true
        spinnerView.backgroundColor = UIColor.darkGray
        spinnerView.color = .white
        spinnerView.layer.cornerRadius = Constant.cornerRadius

        return spinnerView
    }()

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        addSubviewsAndConstraints()
    }

    private func addSubviewsAndConstraints() {
        addSubview(spinnerView)

        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: Constant.length),
            spinnerView.widthAnchor.constraint(equalToConstant: Constant.length)
        ])
    }

    // MARK: - Actions

    func update(with viewModel: FilmographyViewModel) {
        isUserInteractionEnabled = viewModel.isUserInteractionEnabled
        spinnerView.isHidden = viewModel.isSpinnerHidden
    }
}
