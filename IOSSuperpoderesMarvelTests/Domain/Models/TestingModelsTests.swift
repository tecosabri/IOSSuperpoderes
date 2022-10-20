//
//  TestingModelsTests.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 18/10/22.
//

import XCTest
@testable import IOSSuperpoderesMarvel

final class TestingModelsTests: XCTestCase {
    
    func test_GetCharactersTesting_WhenCalled_ReturnsNotNilObject() {
        // Given
        // When
        let object = TestingModels.getCharactersTesting()
        // Then
        XCTAssertNotNil(object, "GetCharactersTesting must return a non nil object")
    }
    
    func test_GetCharactersTesting_WhenCalled_ReturnsFourCharactersArray() {
        // Given
        // When
        let object = TestingModels.getCharactersTesting()
        // Then
        XCTAssertEqual(object.count, 4, "The number of characters must be 4")
    }
    
    func test_GetCharactersTesting_WhenCalled_ReturnsArrayWithWolverineAsItsFirstElement() {
        // Given
        // When
        let object = TestingModels.getCharactersTesting()
        // Then
        XCTAssertEqual(object[0].character.name, "Wolverine", "The name of the first character must be Wolverine")
    }
    
    func test_GetSeriesTesting_WhenCalled_ReturnsNotNilObject() {
        // Given
        // When
        let object = TestingModels.getSeriesTesting()
        // Then
        XCTAssertNotNil(object, "GetSeriesTesting must return a non nil object")
    }
    
    func test_GetSeriesTesting_WhenCalled_ReturnsThreeSeriesArray() {
        // Given
        // When
        let object = TestingModels.getSeriesTesting()
        // Then
        XCTAssertEqual(object.count, 3, "The number of series must be 3")
    }
    
    func test_GetSeriesTesting_WhenCalled_ReturnsArrayWithAPlusXAsItsFirstElement() {
        // Given
        // When
        let object = TestingModels.getSeriesTesting()
        // Then
        XCTAssertEqual(object[0].title, "A+X (2012 - 2014)", "The name of the first serie must be A+X (2012 - 2014)")
    }
}
