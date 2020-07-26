//
//  CharacterListInteractor.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

class CharacterListInteractor {
    weak var output: CharacterListInteractorOutput?
    private let webService: CharactersWebServiceProtocol

    init(webService: CharactersWebServiceProtocol) {
        self.webService = webService
    }
}

// MARK: - CharacterListInteractorInteractorInput

extension CharacterListInteractor: CharacterListInteractorInput {
    func loadCharacters() {
        webService.getCharacters(completion: { [weak self] result in
            switch result {
            case .success(let characters):
                self?.output?.didFetchCharacters(characters: characters)
            case .failure(let error):
                self?.output?.didLoadDataWithError(error: error)
            }
        })
    }

}
