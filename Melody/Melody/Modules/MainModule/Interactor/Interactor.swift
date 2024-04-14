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
    func loadModels(response: iTunesResponse) {
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
                self.output?.viewModels.append(viewModel)
                
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
                self.output?.detailModels.append(detailModel)
            }
            
            dispatchGroup.notify(queue: .main) {
                self.output?.didFinish()
            }
        }
    }
    
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
