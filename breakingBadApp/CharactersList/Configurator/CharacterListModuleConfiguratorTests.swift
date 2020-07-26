//
//  CharacterListModuleConfiguratorTests.swift
//  breakingBadAppTests
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

@testable import breakingBadApp
import XCTest

class CharacterListModuleConfiguratorTests: XCTestCase {
    func testConfigure() {
        let mockErrorHandler = MockErrorHandler(viewController: UIViewController())
        let viewController = CharacterListModuleConfigurator.createModule(errorHandler: mockErrorHandler, completionHandler: { _ in })

        XCTAssert(viewController is CharacterListViewController, "The viewController is not CharacterListViewController")

        let moduleViewController = viewController as! CharacterListViewController

        XCTAssertNotNil(moduleViewController.output, "The view output is nil")
        XCTAssertTrue(moduleViewController.output is CharacterListPresenter, "The view output is not CharacterListPresenter")

        let presenter: CharacterListPresenter = moduleViewController.output as! CharacterListPresenter

        XCTAssertNotNil(presenter.view, "The view in CharacterListPresenter is nil after configuration")
        XCTAssertTrue(presenter.interactor is CharacterListInteractor, "The interactor is not CharacterListInteractor")

        let interactor: CharacterListInteractor = presenter.interactor as! CharacterListInteractor
        XCTAssertNotNil(interactor.output, "The interactor output is nil")
    }
}

private class MockErrorHandler: ErrorHandler {
}
