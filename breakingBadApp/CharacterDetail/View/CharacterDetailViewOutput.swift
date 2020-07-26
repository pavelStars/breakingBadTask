//
//  CharacterDetailViewOutput.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

protocol CharacterDetailViewOutput {
    func viewIsReady()
    func getCharacterInfo() -> CharacterViewModel
    func getOccupationsString() -> String
    func getSeasonAppearanceString() -> String
}
