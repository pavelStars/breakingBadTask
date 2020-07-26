//
//  CharacterListPresenter.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

enum CharacterSection<T> {
    case empty
    case viewModels([T])
}

class CharacterListPresenter {
    unowned var view: CharacterListViewInput
    var interactor: CharacterListInteractorInput
    var errorHandler: ErrorHandler?
    var completionHandler: CharacterListCompletionHandler?
    private var characterSection: CharacterSection<CharacterViewModel> = .empty

    private var allCharacters: [FilmCharacter] = [] {
        didSet {
            let viewModels = allCharacters.map({ CharacterViewModel(character: $0) })
            if viewModels.count > 0 {
                characterSection = .viewModels(viewModels)
            }
            view.display(characterSection: characterSection)
        }
    }

    private var filteredCharacters: [FilmCharacter] = [] {
        didSet {
            let viewModels = filteredCharacters.map({ CharacterViewModel(character: $0) })
            if viewModels.count > 0 {
                characterSection = .viewModels(viewModels)
            }
            view.display(characterSection: characterSection)
        }
    }

    init(view: CharacterListViewInput,
         interactor: CharacterListInteractorInput,
         errorHandler: ErrorHandler?,
         completionHandler: CharacterListCompletionHandler?) {
        self.view = view
        self.interactor = interactor
        self.errorHandler = errorHandler
        self.completionHandler = completionHandler
    }

    private func requestCharacters() {
        view.startActivityIndicator()
        interactor.loadCharacters()
    }
}

// MARK: - CharacterListPresenterViewOutput

extension CharacterListPresenter: CharacterListViewOutput {
    func didMakeSearchWithString(string: String, isFiltering: Bool) {
        guard isFiltering else {
            filteredCharacters = allCharacters
            return
        }
        filteredCharacters = allCharacters.filter({ $0.name.contains(string) })
    }

    func didTap(stationViewModel: CharacterViewModel) {
    }

    func viewIsReady() {
    }

    func loadCharacters() {
        requestCharacters()
    }
}

// MARK: - CharacterListPresenterInteractorOutput

extension CharacterListPresenter: CharacterListInteractorOutput {
    func didFetchCharacters(characters: [FilmCharacter]) {
        view.stopActivityIndicator()
        allCharacters = characters
    }

    func didLoadDataWithError(error: Error) {
        view.stopActivityIndicator()
        errorHandler?.handleError(error)
    }
}
