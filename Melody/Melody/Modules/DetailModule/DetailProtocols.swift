//
//  DetailProtocols.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation

protocol DetailModuleInput {
    func configure(with detailViewModel: DetailViewModel)
}

protocol DetailModuleOutput: AnyObject {
}

protocol DetailViewInput: AnyObject {
}

protocol DetailViewOutput: AnyObject {
    func didPressTrackViewButton(trackViewUrl: String)
    func didPressLookupButton(url: String)
}

protocol DetailInteractorInput: AnyObject {
    func loadAuthorUrl(url: String)
}

protocol DetailInteractorOutput: AnyObject {
    func didRecieveAuthor(result: Result<authorResponse, Error>)
}

protocol DetailRouterInput: AnyObject {
    func openTrackView(urlStringToOpen: String)
    func openAuthorView(urlStringToOpen: String)
    func openErrorAlert(with failure: String)
}
