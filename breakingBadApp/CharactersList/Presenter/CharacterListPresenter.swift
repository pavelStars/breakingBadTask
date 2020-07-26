//
//  CharacterListPresenter.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

class CharacterListPresenter {
    unowned var view: CharacterListViewInput
    var interactor: CharacterListInteractorInput
    var errorHandler: ErrorHandler?
    var completionHandler: CharacterListCompletionHandler?

    init(view: CharacterListViewInput,
         interactor: CharacterListInteractorInput,
         errorHandler: ErrorHandler?,
         completionHandler: CharacterListCompletionHandler?) {
        self.view = view
        self.interactor = interactor
        self.errorHandler = errorHandler
        self.completionHandler = completionHandler
    }
}

// MARK: - CharacterListPresenterViewOutput

extension CharacterListPresenter: CharacterListViewOutput {
    func viewIsReady() {
    }
}

// MARK: - CharacterListPresenterInteractorOutput

extension CharacterListPresenter: CharacterListInteractorOutput {
}
