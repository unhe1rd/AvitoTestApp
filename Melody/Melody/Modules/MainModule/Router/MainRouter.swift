//
//  MainRouter.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//

import Foundation
import UIKit

final class MainRouter {
    weak var viewController: MainViewController?
}

extension MainRouter: MainRouterInput {
    func openErrorAlert(with failure: String) {
        let alert = UIAlertController(title: nil, message: failure, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openDetailModule() {
        print(#function)
    }
    
}
