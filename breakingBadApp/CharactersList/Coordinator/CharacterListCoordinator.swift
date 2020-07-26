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
                                                                               completionHandler: {
        })
        navigationController.pushViewController(characterListModule, animated: true)
    }
}

protocol Coordinator: class {
    func start()
}
