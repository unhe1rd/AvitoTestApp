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
            print("[DEBUG] add to history \(query)")
        }
    }
    
    func didLoadData(with response: iTunesResponse) {
        var viewModels: [MainViewModel] = []
        var detailModels: [DetailViewModel] = []
        let dispatchGroup = DispatchGroup()
        
        for item in response.results {
            dispatchGroup.enter()
            
            SearchNetworkManager.shared.downloadImage(from: item.artworkUrl100) { result in
                defer {
                    dispatchGroup.leave()
                }
                
                guard let image = result else {
                    return
                }
                
                let viewModel = MainViewModel(
                    title: item.trackName ?? item.collectionName ?? "Name N/F",
                    contentType: item.wrapperType,
                    contentImage: image
                )
                viewModels.append(viewModel)
                
                guard let trackViewUrl = item.trackViewUrl else { return }
                let detailModel = DetailViewModel(
                    title: item.trackName ?? item.collectionName ?? "Name N/F",
                    authorName: item.artistName,
                    contentType: item.wrapperType,
                    trackViewUrl: trackViewUrl,
                    description: item.longDescription ?? "Description N/F",
                    artictLinkUrl: NetworkConstants.baseLookupURl + String(item.artistId),
                    contentImage: image
                )
                detailModels.append(detailModel)
            }
            
            dispatchGroup.notify(queue: .main) {
                self.view?.configure(with: viewModels, with: detailModels)
            }
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

