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
                        }
                    ],
                    "returned": 1
                }
            }]
    }
}
"""
    
    let charactersToOrderJSON = """
{
    "data": {
        "offset": 0,
        "limit": 20,
        "total": 1562,
        "count": 20,
        "results": [
            {
                "id": 1017857,
                "name": "AAA",
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
                        }
                    ],
                    "returned": 1
                }
            },
            {
                "id": 101785,
                "name": "BBB",
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
                        }
                    ],
                    "returned": 1
                }
            }]
    }
}
"""
    
    func test_Init_WhenInitWithTesting_TestingModelIsLoaded() {
        // Given
        // When
        let sut = CharactersViewModel(withUITesting: true)
        // Then
        XCTAssertEqual(sut.characters?.count, 4)
        XCTAssertEqual(sut.characters?[0].character.name, "Wolverine")
    }
    
    func test_FetchCharacters_WhenRequestSucceed_ReceivesCorrectData() {
        // Given
        let data = try? XCTUnwrap(charactersJSON.data(using: .utf8))
        let sut = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters")
        // When
        sut.fetchCharacters(filter: [Parameter(parameterName: .name, value: "Peggy Carter (Captain Carter)")])
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
        let sut = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters")
        // When
        sut.getCharacters(filter: [Parameter(parameterName: .name, value: "Peggy Carter (Captain Carter)")]) { character in
            guard let character else { return }
            // Then
            XCTAssertEqual("Peggy Carter (Captain Carter)", character.name)
            if character.name == "Peggy Carter (Captain Carter)" { charactersUpdatedExpectation.fulfill()}
        }
        wait(for: [charactersUpdatedExpectation], timeout: 1)
    }
    
    func test_GetCharacters_WhenRequestFails_StatusSetToError() {
        // Given
        let error = MockError()
        let sut = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .failure(error)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters")
        // When
        sut.getCharacters(filter: [Parameter(parameterName: .name, value: "Peggy Carter (Captain Carter)")]) { character in
            // Then
            XCTAssertNil(character)
            if character == nil {
                charactersUpdatedExpectation.fulfill()
            }
        }
        wait(for: [charactersUpdatedExpectation], timeout: 1)
    }
    
    func test_OnChangeSearchText_WhenSearchTextIsEmpty_CharactersIsEmptyArray() {
        // Given
        let sut = CharactersViewModel()
        // When
        sut.onChangeSearchText(searchText: "")
        // Then
        XCTAssertEqual(sut.characters?.count, 0)
    }
    
    func test_OnChangeSearchText_WhenSearchTextIsNotEmpty_CharactersAreSortedAlphabetically()  {
        // Given
        let data = try? XCTUnwrap(charactersToOrderJSON.data(using: .utf8))
        let sut = CharactersViewModel(networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let charactersUpdatedExpectation = XCTestExpectation(description: "Updates characters sorted")
        // When
        sut.onChangeSearchText(searchText: "AAA") { character in
            XCTAssertEqual(character?.name, "AAA")
            if character?.name == "AAA" { charactersUpdatedExpectation.fulfill()}
        }
        // Then
        wait(for: [charactersUpdatedExpectation], timeout: 1)
    }
}
