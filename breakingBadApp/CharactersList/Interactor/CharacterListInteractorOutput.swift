//
//  CharacterListInteractorOutput.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

protocol CharacterListInteractorOutput: class {
    func didFetchCharacters(characters: [FilmCharacter])
    func didLoadDataWithError(error: Error)
}
