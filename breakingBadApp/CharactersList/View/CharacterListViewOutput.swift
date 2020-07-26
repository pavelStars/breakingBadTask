//
//  CharacterListViewOutput.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

protocol CharacterListViewOutput {
    func viewIsReady()
    func loadCharacters()
    func didMakeSearchWithString(string: String, isFiltering: Bool)
    func didTap(characterViewModel: CharacterViewModel)
    func didTapOnSeasonFiltering()
    func didSelectSeasonToSortBy(season: Int, isFiltering: Bool)
}
