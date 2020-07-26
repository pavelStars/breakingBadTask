//
//  UIViewController+ErrorHandler.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

private enum Constants {
    static let errorTittle: String = "Error"
}

extension UIViewController {
    func displayDialog(forError: Error) {
        let errorMessage = forError.localizedDescription
        let alertControler = UIAlertController(title: Constants.errorTittle,
                                               message: errorMessage,
                                               preferredStyle: .alert)
        present(alertControler, animated: true, completion: nil)
    }
}
