//
//  ViewController.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var characterListCoordinator: CharacterListCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startAppButton(_ sender: UIButton) {
        // startflow

        let errorHandler = ErrorHandler(viewController: self)

        guard let navigationViewController = navigationController else {
            return
        }

        characterListCoordinator = CharacterListCoordinator(navigationController: navigationViewController,
                                                            errorHandler: errorHandler)
        characterListCoordinator?.start()
    }
}
