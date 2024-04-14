//
//  pRESENTER.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//

import Foundation
import UIKit

final class MainPresenter {
    weak var view: MainViewInput?

    private let router: MainRouterInput
    private let interactor: MainInteractorInput
    private var searchDebounser: Debouncer?
    
    var viewModels: [MainViewModel] = []
    var detailModels: [DetailViewModel] = []
    
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainViewOutput {
    func didTapOnCell(model: DetailViewModel) {
        router.openDetailModule(with: model)
    }
    
    func didLoadView() {
        UserDefaults.standard.set(30, forKey: "limit")
    }
    
    func didSearchBarBookmarkButtonClicked(isUsingDefaultLimit: Bool) {
        if isUsingDefaultLimit == true {
            UserDefaults.standard.set(30, forKey: "limit")
        } else {
            UserDefaults.standard.set(200, forKey: "limit")
        }
    }
    
    
    func didChangeSearchText(searchText: String) {
        searchDebounser?.reset()
        searchDebounser = Debouncer(delay: 0.8) {
            self.detailModels = []
            self.viewModels = []
            self.interactor.loadData(searchText: searchText)
            self.addSearchQueryToHistory(query: searchText)
        }
        searchDebounser?.call()
    }
    
    func showError(with failure: String) {
        router.openErrorAlert(with: failure)
    }
    
}

private extension MainPresenter {
    func addSearchQueryToHistory(query: String) {
        var searchHistory = UserDefaults.standard.stringArray(forKey: "searchHistory") ?? [String]()
        if query != ""{
            searchHistory.insert(query, at: 0)
            if searchHistory.count > 5 {
                searchHistory = Array(searchHistory.prefix(5))
            }
            UserDefaults.standard.set(searchHistory, forKey: "searchHistory")
        }
    }
    
    func didLoadData(with response: iTunesResponse) {
        interactor.loadModels(response: response)
    }
}
    
extension MainPresenter: MainInteractorOutput{
    func didFinish(){
        self.view?.configure(with: self.viewModels, with: self.detailModels)
    }
    
    func didRecieve(result: Result<iTunesResponse, Error>) {
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

