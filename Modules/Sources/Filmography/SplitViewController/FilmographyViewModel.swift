//
//  FilmographyViewModel.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import Foundation

struct FilmographyViewModel {

    // MARK: - Properties

    private let isDataReady: Bool

    var isUserInteractionEnabled: Bool {
        isDataReady
    }

    var isSpinnerHidden: Bool {
        isDataReady
    }

    // MARK: - Life Cycle

    init(isDataReady: Bool) {
        self.isDataReady = isDataReady
    }
}
