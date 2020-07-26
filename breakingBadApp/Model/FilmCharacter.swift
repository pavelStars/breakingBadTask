//
//  FilmCharacter.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

struct FilmCharacter: Codable, Equatable {
    let charID: Int
    let name: String
    let birthday: String
    let occupations: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]

    private enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name
        case birthday
        case occupations = "occupation"
        case img
        case status
        case nickname
        case appearance
    }
}
