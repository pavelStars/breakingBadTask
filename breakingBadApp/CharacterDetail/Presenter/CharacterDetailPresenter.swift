//
//  CharacterDetailPresenter.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

class CharacterDetailPresenter {
    private unowned var view: CharacterDetailViewInput
    private var interactor: CharacterDetailInteractorInput
    private var errorHandler: ErrorHandler?
    private var completionHandler: CharacterDetailCompletionHandler?
    private var viewModel: CharacterViewModel

    init(view: CharacterDetailViewInput,
         interactor: CharacterDetailInteractorInput,
         errorHandler: ErrorHandler?,
         completionHandler: CharacterDetailCompletionHandler?,
         viewModel: CharacterViewModel) {
        self.view = view
        self.interactor = interactor
        self.errorHandler = errorHandler
        self.completionHandler = completionHandler
        self.viewModel = viewModel
    }
}

// MARK: - CharacterDetailPresenterViewOutput

extension CharacterDetailPresenter: CharacterDetailViewOutput {
    func getOccupationsString() -> String {
        var occupationsString: String = ""
        for occupation in viewModel.occupations {
            if occupationsString != "" {
                occupationsString += ", \(occupation)"
            } else {
                occupationsString = occupation
            }
        }
        return occupationsString
    }

    func getSeasonAppearanceString() -> String {
        var seasonString: String = ""
        for season in viewModel.appearance {
            if seasonString != "" {
                seasonString += ", \(season)"
            } else {
                seasonString = "\(season)"
            }
        }
        return seasonString
    }

    func getCharacterInfo() -> CharacterViewModel {
        return viewModel
    }

    func viewIsReady() {
    }
}

// MARK: - CharacterDetailPresenterInteractorOutput

extension CharacterDetailPresenter: CharacterDetailInteractorOutput {
}
