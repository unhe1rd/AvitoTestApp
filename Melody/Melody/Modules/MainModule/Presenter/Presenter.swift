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
    
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainViewOutput {
    func didChangeSearchText(searchText: String) {
        searchDebounser?.reset()
        searchDebounser = Debouncer(delay: 0.8) {
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
    func didLoadData(with response: iTunesResponse) {
        var viewModels: [MainViewModel] = []
        
        let dispatchGroup = DispatchGroup()

        for cellModel in response.results {
            dispatchGroup.enter()

            SearchNetworkManager.shared.downloadImage(from: cellModel.artworkUrl100) { result in
                defer {
                    dispatchGroup.leave()
                }

                guard let image = result else {
                    return
                }

                let viewModel = MainViewModel(
                    title: cellModel.trackName ?? "123",
                    contentType: cellModel.wrapperType,
                    contentImage: image
                )
                viewModels.append(viewModel)
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.view?.configure(with: viewModels)
        }
    }
    
    func addSearchQueryToHistory(query: String) {
        var searchHistory = UserDefaults.standard.stringArray(forKey: "searchHistory") ?? [String]()
        if query != ""{
            searchHistory.insert(query, at: 0)
            if searchHistory.count > 5 {
                searchHistory = Array(searchHistory.prefix(5))
            }
            UserDefaults.standard.set(searchHistory, forKey: "searchHistory")
            print("[DEBUG] add to history \(query)")
        }
    }
}

extension MainPresenter: MainInteractorOutput{
    func didRecieve(result: Result<iTunesResponse, Error>) {
        DispatchQueue.global().async {
            switch result {
            case .success(let success):
                self.didLoadData(with: success)
                print(success.resultCount)
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self.showError(with: failure.localizedDescription)
                }
            }
        }
    }
}
