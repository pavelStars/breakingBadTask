//
//  CharacterDetailPresenterTests.swift
//  breakingBadAppTests
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

@testable import breakingBadApp
import XCTest

class CharacterDetailPresenterTests: XCTestCase {
    private var presenter: CharacterDetailPresenter!
    private var interactor: MockInteractor!
    private var view: MockViewController!
    private var mockErrorHandler: MockErrorHandler!

    override func setUp() {
        super.setUp()

        view = MockViewController()
        interactor = MockInteractor()
        mockErrorHandler = MockErrorHandler(viewController: UIViewController())

        let viewModel = CharacterViewModel(character: FilmCharacter(charID: 1,
                                                                    name: "",
                                                                    birthday: "",
                                                                    occupations: ["Dentist", "Doctor", "Hero"],
                                                                    img: "",
                                                                    status: "",
                                                                    nickname: "",
                                                                    appearance: [1, 2]))

        presenter = CharacterDetailPresenter(view: view,
                                             interactor: interactor,
                                             errorHandler: mockErrorHandler,
                                             completionHandler: {},
                                             viewModel: viewModel)
    }

    func testGetOccupationStringCorrect() {
        let finalString = "Dentist, Doctor, Hero"
        let parsedString = presenter.getOccupationsString()
        XCTAssertEqual(finalString, parsedString)
    }

    func testGetOccupationStringIncorrect() {
        let finalString = "Dentist, Doctor"
        let parsedString = presenter.getOccupationsString()
        XCTAssertNotEqual(finalString, parsedString)
    }

    func testGetAppearanceCorrect() {
        let finalString = "1, 2"
        let parsedString = presenter.getSeasonAppearanceString()
        XCTAssertEqual(finalString, parsedString)
    }

    func testGetAppearanceIncorrect() {
        let finalString = "1 2"
        let parsedString = presenter.getSeasonAppearanceString()
        XCTAssertNotEqual(finalString, parsedString)
    }
}

private class MockInteractor: CharacterDetailInteractorInput {
}

private class MockViewController: CharacterDetailViewInput {
    func startActivityIndicator() {
    }

    func stopActivityIndicator() {
    }
}

private class MockErrorHandler: ErrorHandler {
}
