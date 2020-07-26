//
//  CharacterListCoordinatorTests.swift
//  breakingBadAppTests
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

@testable import breakingBadApp
import XCTest

class CharacterListCoordinatorTests: XCTestCase {
    var coordinator: CharacterListCoordinator!
    private let navigationController = MockNavigationController()
    private let errorHandler = MockErrorHandler(viewController: UIViewController())

    override func setUp() {
        super.setUp()
        coordinator = CharacterListCoordinator(navigationController: navigationController,
                                               errorHandler: errorHandler)
    }

    func testStartCalled() {
         coordinator.start()
         XCTAssertFalse(navigationController.viewControllers.isEmpty)
         XCTAssertTrue(navigationController.visibleViewController is CharacterListViewController)
     }
}

private class MockErrorHandler: ErrorHandler {
}

private class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var didPopViewController: Bool = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        didPopViewController = true
        return super.popViewController(animated: animated)
    }
}
