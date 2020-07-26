//
//  CharacterViewModel.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

struct CharacterViewModel: Equatable {
     let name: String
     let occupations: [String]
     let img: String
     let status: String
     let nickname: String
     let appearance: [Int]

    init(character: FilmCharacter) {
        name = character.name
        occupations = character.occupations
        img = character.img
        status = character.status
        nickname = character.nickname
        appearance = character.appearance
    }

}
