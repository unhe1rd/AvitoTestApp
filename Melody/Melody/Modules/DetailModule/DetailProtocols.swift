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
}

protocol DetailInteractorInput: AnyObject {
}

protocol DetailInteractorOutput: AnyObject {
}

protocol DetailRouterInput: AnyObject {
    func openTrackView(urlStringToOpen: String)
}
