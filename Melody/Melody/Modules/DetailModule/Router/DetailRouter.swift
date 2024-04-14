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
    func openAuthorView(urlStringToOpen: String) {
        deeplinkManager.open(urlString: urlStringToOpen)
    }
    
    func openTrackView(urlStringToOpen: String) {
        deeplinkManager.open(urlString: urlStringToOpen)
    }
    
    func openErrorAlert(with failure: String) {
        let alert = UIAlertController(title: nil, message: failure, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.viewController?.present(alert, animated: true, completion: nil)
        }
    }
}
