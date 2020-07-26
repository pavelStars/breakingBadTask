//
//  CharacterDetailViewController.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nickname: UILabel!
    @IBOutlet private weak var ocuppation: UILabel!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var seasonAppearance: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!

    var output: CharacterDetailViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailScreen()

        output?.viewIsReady()
    }

    private func configureDetailScreen() {
        guard let viewModel = output?.getCharacterInfo() else {
            return
        }
        nameLabel.text = viewModel.name
        nickname.text = viewModel.nickname
        ocuppation.text = "Occupations: \(output?.getOccupationsString() ?? "")"
        status.text = viewModel.status
        seasonAppearance.text = output?.getSeasonAppearanceString() ?? ""

        guard let url = URL(string: viewModel.img) else {
            return
        }
        setupImage(url: url)
    }

    private func setupImage(url: URL) {
        characterImageView.sd_setImage(with: url,
                                       placeholderImage: UIImage(named: "avatar"))
    }
}

extension CharacterDetailViewController: CharacterDetailViewInput {
}
