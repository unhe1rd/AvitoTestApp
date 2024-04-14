//
//  Interactor.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation

final class FavoritesInteractor {
    weak var output: DetailInteractorOutput?
}

extension FavoritesInteractor: DetailInteractorInput {
}
