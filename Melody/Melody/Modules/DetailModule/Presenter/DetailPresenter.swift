//
//  DetailPresenter.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation

final class DetailPresenter {
    weak var view: DetailViewInput?
    weak var moduleOutput: DetailModuleOutput?
    
    private let router: DetailRouterInput
    private let interactor: DetailInteractorInput
    
    init(router: DetailRouterInput, interactor: DetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailViewOutput {
}

extension DetailPresenter: DetailInteractorOutput {
}

extension DetailPresenter: DetailModuleInput {
    func configure(with detailViewModel: DetailViewModel) {
    }
}
