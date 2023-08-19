//
//  CharacterDetailsViewModel.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import FilmographyManager
import UIKit

struct CharacterDetailsViewModel {

    // MARK: - Properties

    private let isCharacterDataSet: Bool

    var isPlaceholderLabelHidden: Bool {
        !isCharacterDataSet
    }

    var isCollectionViewHidden: Bool {
        isCharacterDataSet
    }

    // MARK: - Life Cycle

    init(isCharacterDataSet: Bool) {
        self.isCharacterDataSet = isCharacterDataSet
    }
}
