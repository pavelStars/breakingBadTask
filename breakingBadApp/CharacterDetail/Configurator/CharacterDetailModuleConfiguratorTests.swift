//
//  CharacterDetailModuleConfiguratorTests.swift
//  breakingBadAppTests
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

@testable import breakingBadApp
import XCTest

class CharacterDetailModuleConfiguratorTests: XCTestCase {
    func testConfigure() {
        let viewModel = CharacterViewModel(character: FilmCharacter(charID: 1,
                                                                    name: "",
                                                                    birthday: "",
                                                                    occupations: [""],
                                                                    img: "",
                                                                    status: "",
                                                                    nickname: "",
                                                                    appearance: [1]))
        let mockErrorHandler = MockErrorHandler(viewController: UIViewController())
        let viewController = CharacterDetailModuleConfigurator.createModule(errorHandler: mockErrorHandler,
                                                                            completionHandler: {},
                                                                            viewModel: viewModel)

        XCTAssert(viewController is CharacterDetailViewController, "The viewController is not CharacterDetailViewController")

        let moduleViewController = viewController as! CharacterDetailViewController

        XCTAssertNotNil(moduleViewController.output, "The view output is nil")
        XCTAssertTrue(moduleViewController.output is CharacterDetailPresenter, "The view output is not CharacterDetailPresenter")

        let presenter: CharacterDetailPresenter = moduleViewController.output as! CharacterDetailPresenter

        XCTAssertNotNil(presenter.view, "The view in CharacterDetailPresenter is nil after configuration")
        XCTAssertTrue(presenter.interactor is CharacterDetailInteractor, "The interactor is not CharacterDetailInteractor")

        let interactor: CharacterDetailInteractor = presenter.interactor as! CharacterDetailInteractor
        XCTAssertNotNil(interactor.output, "The interactor output is nil")
    }
}

private class MockErrorHandler: ErrorHandler {
}
