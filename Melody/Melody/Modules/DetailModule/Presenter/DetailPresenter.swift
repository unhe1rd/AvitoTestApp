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
    func didPressLookupButton(url authorUrl: String) {
        self.interactor.loadAuthorUrl(url: authorUrl)
    }
    
    func didPressTrackViewButton(trackViewUrl: String) {
        router.openTrackView(urlStringToOpen: trackViewUrl)
    }
    
    func didLoadData(with response: authorResponse){
        router.openAuthorView(urlStringToOpen: response.results[0].artistLinkUrl)
    }
    
    func showError(with failure: String) {
        router.openErrorAlert(with: failure)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func didRecieveAuthor(result: Result<authorResponse, Error>) {
        DispatchQueue.global().async {
            switch result {
            case .success(let success):
                self.didLoadData(with: success)
            case .failure(let failure):
                self.showError(with: failure.localizedDescription)
            }
        }
    }
    
}

extension DetailPresenter: DetailModuleInput {
    func configure(with detailViewModel: DetailViewModel) {
    }
}
