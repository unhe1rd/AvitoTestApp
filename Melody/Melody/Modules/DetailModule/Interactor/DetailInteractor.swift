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
    func loadAuthorUrl(url: String){
        SearchNetworkManager.shared.loadAuthorUrl(urlString: url){ result in
            switch result {
            case .success(let success):
                self.output?.didRecieveAuthor(result: .success(success))
            case .failure(let failure):
                self.output?.didRecieveAuthor(result: .failure(failure))
            }
        }
    }
}
