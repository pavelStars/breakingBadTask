//
//  CharacterDetailModuleConfigurator.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

typealias CharacterDetailCompletionHandler = () -> Void

class CharacterDetailModuleConfigurator {
    public static func createModule(errorHandler: ErrorHandler,
                                    completionHandler: @escaping CharacterDetailCompletionHandler,
                                    viewModel: CharacterViewModel) -> UIViewController {
        let storyboard = StoryboardProvider.getStoryboard(of: .main)
        let viewController = CharacterDetailViewController.controllerInStoryboard(storyboard)
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter(view: viewController,
                                                 interactor: interactor,
                                                 errorHandler: errorHandler,
                                                 completionHandler: completionHandler,
                                                 viewModel: viewModel)

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
