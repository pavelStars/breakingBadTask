//
//  CharacterListInteractorTests.swift
//  breakingBadAppTests
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

@testable import breakingBadApp
import XCTest

class CharacterListInteractorTests: XCTestCase {
    private var interactor: CharacterListInteractor!
    private var mockWebService: MockWebService!
    private var mockPresenter: MockPresenter!

    override func setUp() {
        super.setUp()
        mockWebService = MockWebService()
        mockPresenter = MockPresenter()

        interactor = CharacterListInteractor(webService: mockWebService)
        interactor.output = mockPresenter
    }

    func testMyCasesNoneEmptyResponse() {
        interactor.loadCharacters()
        let characters = FilmCharacter(charID: 1, name: "", birthday: "", occupations: [""], img: "", status: "", nickname: "", appearance: [1,2,3])
        mockWebService.getCharactersHandler?(.success([characters]))
        XCTAssertEqual(mockPresenter.allFilmCharcaters, [characters])
    }

    func testFailLoadData() {
        interactor.loadCharacters()
        mockWebService.getCharactersHandler?(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        XCTAssertNotNil(mockPresenter.didCallLoadDataWithError, "Mock presenter should receive an error")
    }
}

private class MockWebService: CharactersWebServiceProtocol {
    var getCharactersHandler: ((Result<[FilmCharacter], Error>) -> Void)?

    func getCharacters(completion: @escaping (Result<[FilmCharacter], Error>) -> Void) {
        getCharactersHandler = completion
    }
}

private class MockPresenter: CharacterListInteractorOutput {
    var didCallLoadDataWithError: Error?
    var allFilmCharcaters: [FilmCharacter]?

    func didFetchCharacters(characters: [FilmCharacter]) {
        allFilmCharcaters = characters
    }

    func didLoadDataWithError(error: Error) {
        didCallLoadDataWithError = error
    }
}
