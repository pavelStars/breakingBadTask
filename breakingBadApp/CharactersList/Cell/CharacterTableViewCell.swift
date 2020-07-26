//
//  CharacterTableViewCell.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import SDWebImage
import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!

    func configure(viewModel: CharacterViewModel) {
        name.text = viewModel.name
        guard let imageURL = URL(string: viewModel.img) else {
            return
        }
        characterImageView.sd_setImage(with: imageURL,
                                       placeholderImage: UIImage(named: "avatar"))
    }
}
