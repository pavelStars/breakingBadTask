//
//  ErrorHandler.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

public protocol ErrorHandlerProtocol {
    func handleError(_: Error)
}

class ErrorHandler: ErrorHandlerProtocol {
    private(set) unowned var mainViewController: UIViewController

      public init(viewController: UIViewController) {
          self.mainViewController = viewController
      }

    public func isCriticalError(_ error: Error) -> Bool {
         return false
     }

    public func handleError(_ error: Error) {
         mainViewController.displayDialog(forError: error)
     }
}
