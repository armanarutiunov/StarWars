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

    private var isAllDataFetched: Bool {
        areFilmedFetched && areCharactersFetched
    }

    // MARK: - Actions

    func onFilmsFetched() {
        areFilmedFetched = true
        notifyIfAllDataIsFetched()
    }

    func onCharactersFetched() {
        areCharactersFetched = true
        notifyIfAllDataIsFetched()
    }

    private func notifyIfAllDataIsFetched() {
        if isAllDataFetched {
            delegate?.filmographyDataSourceDataReady()
        }
    }
}
