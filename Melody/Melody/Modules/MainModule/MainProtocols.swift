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
}

protocol MainInteractorInput: AnyObject {
    func loadData(searchText: String)
    func loadImage(imageUrl: String)
}

protocol MainInteractorOutput: AnyObject {
    func didRecieve(result: Result<iTunesResponse, Error>)
}

protocol MainRouterInput: AnyObject {
    func openDetailModule(with model: DetailViewModel)
    func openErrorAlert(with failure: String)
}

protocol MainRouterOutput: AnyObject {
    
}
