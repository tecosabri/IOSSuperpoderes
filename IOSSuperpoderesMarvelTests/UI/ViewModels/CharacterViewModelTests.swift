//
//  CharacterViewModel.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import XCTest
import Combine
@testable import IOSSuperpoderesMarvel

final class CharacterViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    let serieJSON = """
{
    "data": {
        "results": [{
                "id": 32095,
                "title": "Women of Marvel (2021)",
                "description": null,
                "thumbnail": {
                    "path": "http://i.annihil.us/u/prod/marvel/i",
                    "extension": "jpg"
                }
            }
        ]
    }
}
"""
    
    func test_Init_WhenInitWithTesting_TestingModelIsLoaded() {
        // Given
        let character = TestingModels.getCharactersTesting()[0].character
        // When
        let sut = CharacterViewModel(withUITesting: true, fromCharacter: character)
        // Then
        XCTAssertEqual(sut.series?.count, 3)
        XCTAssertEqual(sut.series?[0].title, "A+X (2012 - 2014)")
    }
    
    func test_Equatable_WhenComparedTwoCharacterViewModels_EqualsReturnsFalse() {
        // Given
        let character1 = TestingModels.getCharactersTesting()[0].character
        let character2 = TestingModels.getCharactersTesting()[1].character
        let sut1 = CharacterViewModel(withUITesting: true, fromCharacter: character1)
        let sut2 = CharacterViewModel(withUITesting: true, fromCharacter: character2)
        // When
        let comparingResult = sut1 == sut2
        // Then
        XCTAssertFalse(comparingResult)
    }
    
    func test_Equatable_WhenTwoViewModelsWithTheSameCharacter_EqualsReturnsTrue() {
        // Given
        let character1 = TestingModels.getCharactersTesting()[0].character
        let sut1 = CharacterViewModel(withUITesting: true, fromCharacter: character1)
        let sut2 = CharacterViewModel(withUITesting: true, fromCharacter: character1)
        // When
        let comparingResult = sut1 == sut2
        // Then
        XCTAssertTrue(comparingResult)
    }

    func test_FetchSeries_WhenRequestSucceeds_ReceivesCorrectData() {
        // Given
        let data = serieJSON.data(using: .utf8)
        let character = TestingModels.getCharactersTesting()[0].character
        let sut = CharacterViewModel(fromCharacter: character, networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let seriesUpdatedExpectation = XCTestExpectation(description: "Updates series")
        // When
        sut.fetchSeries()
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { seriesDataWrapper in
                let serieName = seriesDataWrapper.data.results[0].title
                XCTAssertEqual(serieName, "Women of Marvel (2021)")
                seriesUpdatedExpectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [seriesUpdatedExpectation], timeout: 0.5)
    }
    
    func test_GetSeries_WhenRequestSucceds_ReceivesCorrectData() {
        // Given
        let data = serieJSON.data(using: .utf8)
        let character = TestingModels.getCharactersTesting()[0].character
        let sut = CharacterViewModel(fromCharacter: character, networkFetching: NetworkFetchingStub(returning: .success(data!)))
        let seriesUpdatedExpectation = XCTestExpectation(description: "Updates series")
        // When
        sut.getSeries() { serie in
            let notNilSerie = try? XCTUnwrap(serie)
            // Then
            XCTAssertEqual(notNilSerie?.title, "Women of Marvel (2021)")
            seriesUpdatedExpectation.fulfill()
        }
            
        wait(for: [seriesUpdatedExpectation], timeout: 1)
    }
    
    func test_GetSeries_WhenRequestFails_ReturnsNil() {
        // Given
        let error = MockError()
        let character = TestingModels.getCharactersTesting()[0].character
        let sut = CharacterViewModel(fromCharacter: character, networkFetching: NetworkFetchingStub(returning: .failure(error)))
        let seriesUpdatedExpectation = XCTestExpectation(description: "Updates series")
        // When
        sut.getSeries() { serie in
            // Then
            XCTAssertNil(serie)
            seriesUpdatedExpectation.fulfill()
        }
            
        wait(for: [seriesUpdatedExpectation], timeout: 1)
    }
    
}
