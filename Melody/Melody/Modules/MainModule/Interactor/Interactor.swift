//
//  Interactor.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//

import Foundation

final class MainInteractor {
    weak var output: MainInteractorOutput?
}

extension MainInteractor: MainInteractorInput {
    func loadData(searchText: String) {
        SearchNetworkManager.shared.loadData(searchText: searchText){ result in
            switch result {
            case .success(let success):
                self.output?.didRecieve(result: .success(success))
            case .failure(let failure):
                self.output?.didRecieve(result: .failure(failure))
            }
        }
    }
}
