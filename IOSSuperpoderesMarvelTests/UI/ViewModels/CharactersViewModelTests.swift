//
//  CharactersViewModel.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Combine
import XCTest
@testable import IOSSuperpoderesMarvel

final class CharactersViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    let charactersJSON = """
{
    "data": {
        "offset": 0,
        "limit": 20,
        "total": 1562,
        "count": 20,
        "results": [
            {
                "id": 1017857,
                "name": "Peggy Carter (Captain Carter)",
                "description": "",
                "modified": "2022-05-03T11:41:04-0400",
                "thumbnail": {
                    "path": "http://i.annihil.us/u/prod/marvel",
                    "extension": "jpg"
                },
                "resourceURI": "http://gateway.marvel.com/v1/public/characters/1017857",
                "series": {
                    "available": 7,
                    "collectionURI": "http://gateway.marvel.com/v1/public/characters/1017857/series",
                    "items": [
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/20544",
                            "name": "Agent Carter: S.H.I.E.L.D. 50th Anniversary (2015)"
                        },
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/24503",
                            "name": "Captain America (2018 - Present)"
                        },
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/14569",
                            "name": "Captain America and the First Thirteen (2011)"
                        },
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/34322",
                            "name": "Captain Carter (2022)"
                        },
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/24155",
                            "name": "Exiles (2018 - 2019)"
                        },
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/19616",
                            "name": "Operation: S.I.N. (2015)"
                        },
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/32095",
                            "name": "Women of Marvel (2021)"
                        }
                    ],
                    "returned": 7
                }
            }]
    }
}
"""
    
    
    func test_FetchCharacters_WhenRequestSucceed_ReceivesCorrectData() {
        // Given
        let data = try? XCTUnwrap(charactersJSON.data(using: .utf8))
        let charactersFetcher = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters")
        // When
        charactersFetcher.fetchCharacters(filter: [Parameter(parameterName: .name, value: "Peggy Carter (Captain Carter)")])
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            }) { characterDataWrapper in
                let characterName = characterDataWrapper.data.results[0].name
                XCTAssertEqual(characterName, "Peggy Carter (Captain Carter)")
                charactersUpdatedExpectation.fulfill()
            }.store(in: &cancellables)
        wait(for: [charactersUpdatedExpectation], timeout: 1)
    }
    
    func test_GetCharacters_WhenRequestSucceed_ReceivesCorrectData() {
        // Given
        let data = try? XCTUnwrap(charactersJSON.data(using: .utf8))
        let charactersFetcher = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters")
        // When
        charactersFetcher.getCharacters(filter: [Parameter(parameterName: .name, value: "Peggy Carter (Captain Carter)")]) { character in
            guard let character else { return }
            if character.name == "Peggy Carter (Captain Carter)" { charactersUpdatedExpectation.fulfill()}
        }
        wait(for: [charactersUpdatedExpectation], timeout: 1)
    }
    
    func test_GetCharacters_WhenRequestFails_StatusSetToError() {
        // Given
        let error = MockError()
        let data = try? XCTUnwrap(charactersJSON.data(using: .utf8))
        let charactersFetcher = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .failure(error)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters")
        // When
        charactersFetcher.getCharacters(filter: [Parameter(parameterName: .name, value: "Peggy Carter (Captain Carter)")]) { character in
            guard character != nil else {
                charactersUpdatedExpectation.fulfill()
                return
            }
        }
        wait(for: [charactersUpdatedExpectation], timeout: 1)
    }
}
