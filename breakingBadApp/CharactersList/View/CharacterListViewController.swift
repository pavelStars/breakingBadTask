//
//  CharacterListViewController.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    var output: CharacterListViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewIsReady()
    }
}

extension CharacterListViewController: CharacterListViewInput {
}
