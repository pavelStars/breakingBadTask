//
//  CharactersWebService.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

private enum Constants {
    static let charactersEndPoint = "https://breakingbadapi.com/api/characters"
}

protocol CharactersWebServiceProtocol {
    func getCharacters(completion: @escaping (Result<[FilmCharacter], Error>) -> Void)
}

class CharactersWebService: CharactersWebServiceProtocol {
    func getCharacters(completion: @escaping (Result<[FilmCharacter], Error>) -> Void) {
        guard let url = URL(string: Constants.charactersEndPoint) else {
            return
        }
        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(_, let data):
                guard let characterList = try? JSONDecoder().decode([FilmCharacter].self, from: data) else {
                    return
                }
                let result: Result = .wrapWebServiceResult(success: true,
                                                           result: characterList,
                                                           error: nil)

                DispatchQueue.main.async {
                    completion(result)
                }

            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }.resume()
    }
}

extension URLSession {
    func dataTask(with url: URL,
                  result: @escaping (Result<(URLResponse, Data),
                      Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { data, response, error in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

