//
//  DetailAssembly.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation
import UIKit

final class DetailContainer {
    let input: DetailModuleInput
    let viewController: UIViewController
    private(set) weak var router: DetailRouterInput!
    
    class func assemble(with context: DetailContext) -> DetailContainer {
        let router = DetailRouter()
        let interactor = FavoritesInteractor()
        let presenter = DetailPresenter(router: router, interactor: interactor)
        let viewController = DetailViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return DetailContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: DetailModuleInput, router: DetailRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct DetailContext {
    weak var moduleOutput: DetailModuleOutput?
}
