//
//  CharacterListCoordinator.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

class CharacterListCoordinator: Coordinator {
    private var navigationController: UINavigationController
    private var errorHandler: ErrorHandler

    init(navigationController: UINavigationController,
         errorHandler: ErrorHandler) {
        self.navigationController = navigationController
        self.errorHandler = errorHandler
    }

    func start() {
        let characterListModule = CharacterListModuleConfigurator.createModule(errorHandler: errorHandler,
                                                                               completionHandler: { [weak self] action in
                                                                                   self?.handleStationsRedirectionAction(action)
        })
        navigationController.pushViewController(characterListModule, animated: true)
    }

    private func handleStationsRedirectionAction(_ action: CharacterRedirectionAction) {
        switch action {
        case .lisCharacters:
            break
        case .detailCharacter(let viewModel):
            startDetailScreen(characterViewModel: viewModel)
        }
    }

    private func startDetailScreen(characterViewModel: CharacterViewModel) {
        let viewController = CharacterDetailModuleConfigurator.createModule(errorHandler: errorHandler, completionHandler: {

        }, viewModel: characterViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

protocol Coordinator: class {
    func start()
}
