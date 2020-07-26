//
//  CharacterListModuleConfigurator.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

enum CharacterRedirectionAction {
    case lisCharacters
    case detailCharacter(CharacterViewModel)
}

typealias CharacterListCompletionHandler = (CharacterRedirectionAction) -> Void

class CharacterListModuleConfigurator {
    public static func createModule(errorHandler: ErrorHandler,
                                    completionHandler: @escaping CharacterListCompletionHandler) -> UIViewController {
        let storyboard = StoryboardProvider.getStoryboard(of: .main)
        let viewController = CharacterListViewController.controllerInStoryboard(storyboard)
        let interactor = CharacterListInteractor(webService: CharactersWebService())
        let presenter = CharacterListPresenter(view: viewController, interactor: interactor, errorHandler: errorHandler, completionHandler: completionHandler)

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
