//
//  CharacterListViewInput.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

protocol CharacterListViewInput: Activable {
    func display(characterSection: CharacterSection<CharacterViewModel>)
    func showAllSeasonPicker(data: [Int])
}
