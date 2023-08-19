//
//  FilmographyDataSource.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

protocol FilmographyDataSourceDelegate: AnyObject {
    func filmographyDataSourceDataReady()
}

final class FilmographyDataSource {

    // MARK: - Properties

    weak var delegate: FilmographyDataSourceDelegate?

    private var areFilmedFetched = false

    var areCharactersFetched = false

    private var isAllDataReady: Bool {
        areFilmedFetched && areCharactersFetched
    }

    // MARK: - Actions

    func onFilmsFetched() {
        areFilmedFetched = true
        notifyIfDataIsReady()
    }

    func onCharactersFetched() {
        areCharactersFetched = true
        notifyIfDataIsReady()
    }

    private func notifyIfDataIsReady() {
        if isAllDataReady {
            delegate?.filmographyDataSourceDataReady()
        }
    }
}
