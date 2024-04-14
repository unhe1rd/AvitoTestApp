//
//  DetailRouter.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation
import UIKit

final class DetailRouter {
    weak var viewController: DetailViewController?
    private let deeplinkManager = DeeplinkManager.shared
}

extension DetailRouter: DetailRouterInput {
    func openTrackView(urlStringToOpen: String) {
        deeplinkManager.open(urlString: urlStringToOpen)
    }
}
