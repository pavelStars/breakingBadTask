//
//  CharacterListPresenterTests.swift
//  breakingBadAppTests
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

@testable import breakingBadApp
import XCTest

class CharacterListPresenterTests: XCTestCase {
    private var presenter: CharacterListPresenter!
    private var interactor: MockInteractor!
    private var view: MockViewController!
    private var mockErrorHandler: MockErrorHandler!

    override func setUp() {
        super.setUp()

        view = MockViewController()
        interactor = MockInteractor()
        mockErrorHandler = MockErrorHandler(viewController: UIViewController())

        presenter = CharacterListPresenter(view: view,
                                           interactor: interactor,
                                           errorHandler: mockErrorHandler,
                                           completionHandler: { _ in })
    }

    func testHasCalledLoadCharacters() {
        presenter.loadCharacters()
        XCTAssertTrue(interactor.hasCalledLoadCharacters)
        XCTAssertTrue(view.isActivityIndicatorWorking)
    }

    func testSectionDisplay() {
        let filmChar = FilmCharacter(charID: 1,
                                     name: "",
                                     birthday: "",
                                     occupations: ["Dentist", "Doctor", "Hero"],
                                     img: "",
                                     status: "",
                                     nickname: "",
                                     appearance: [1, 2])
        presenter.didFetchCharacters(characters: [filmChar])
        let charViewModel = CharacterViewModel(character: filmChar)

        XCTAssertFalse(view.isActivityIndicatorWorking)
        switch view.section {
        case .viewModels(let viewModels):
            XCTAssertEqual([charViewModel], viewModels)
        default:
            XCTFail()
        }
    }

    func testSeasonPickerInfo() {
        presenter.didTapOnSeasonFiltering()
        XCTAssertEqual(view.dataSeasons, [1, 2, 3, 4, 5])
    }
}

private class MockInteractor: CharacterListInteractorInput {
    var hasCalledLoadCharacters: Bool = false

    func loadCharacters() {
        hasCalledLoadCharacters = true
    }
}

private class MockViewController: CharacterListViewInput {
    var isActivityIndicatorWorking: Bool = false
    var section: CharacterSection<CharacterViewModel> = .empty
    var dataSeasons: [Int] = []

    func display(characterSection: CharacterSection<CharacterViewModel>) {
        section = characterSection
    }

    func showAllSeasonPicker(data: [Int]) {
        dataSeasons = data
    }

    func startActivityIndicator() {
        isActivityIndicatorWorking = true
    }

    func stopActivityIndicator() {
        isActivityIndicatorWorking = false
    }
}

private class MockErrorHandler: ErrorHandler {
}
