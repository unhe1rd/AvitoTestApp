//
//  MainProtocols.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//


import Foundation
import UIKit

protocol MainViewOutput: AnyObject {
    func didChangeSearchText(searchText: String)
    func didSearchBarBookmarkButtonClicked(isUsingDefaultLimit: Bool)
    func didLoadView()
    func didTapOnCell(model: DetailViewModel)
}

protocol MainViewInput: AnyObject {
    func configure(with model: [MainViewModel], with detailModel: [DetailViewModel])
    func stopLoader()
    func startLoader()
}

protocol MainInteractorInput: AnyObject {
    func loadData(searchText: String)
    func loadModels(response: iTunesResponse)
}

protocol MainInteractorOutput: AnyObject {
    func didRecieve(searchText: String, result: Result<iTunesResponse, Error>)
    func didFinish()
    var viewModels: [MainViewModel] { get set }
    var detailModels: [DetailViewModel] { get set }
}

protocol MainRouterInput: AnyObject {
    func openDetailModule(with model: DetailViewModel)
    func openErrorAlert(with failure: String)
}

protocol MainRouterOutput: AnyObject {
    
}
