//
//  NetworkHelperTests.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 18/10/22.
//

import XCTest
@testable import IOSSuperpoderesMarvel

final class NetworkHelperTests: XCTestCase {

    func test_GetSessionCharacters_WhenCalledWithEmptyArray_ReturnsNotNilObject() {
        // Given
        // When
        let sessionCharacters = NetworkHelper.getSessionCharacters(filter: [])
        // Then
        XCTAssertNotNil(sessionCharacters, "GetSessionCharacters() must return a not nil URLRequest")
    }
    
    func test_GetSessionCharacters_WhenCalledWithEmptyArray_HasGetHTTPMethod() {
        // Given
        // When
        let sessionCharacters = try? XCTUnwrap(NetworkHelper.getSessionCharacters(filter: []))
        // Then
        XCTAssertEqual(sessionCharacters!.httpMethod, HTTPMethods.get, "The HTTPMethod of the request has to be GET")
    }
    
    func test_GetSessionCharacters_WhenCalledWithEmptyArray_SessionContainsRawServerPlusEndpointURL() {
        // Given
        // When
        let sessionCharacters = try? XCTUnwrap(NetworkHelper.getSessionCharacters(filter: []))
        // Then
        XCTAssertTrue(sessionCharacters!.url!.absoluteString.contains("https://gateway.marvel.com/v1/public/characters"), "The url of the request must contain the endpoint")
    }
    
    func test_GetSessionCharacters_WhenCalledWithNameFilter_SessionContainsNameInItsURL() {
        // Given
        // When
        let sessionCharacters = try? XCTUnwrap(NetworkHelper.getSessionCharacters(filter: [Parameter(parameterName: .name, value: "randomName")]))
        // Then
        XCTAssertTrue(sessionCharacters!.url!.absoluteString.contains("randomName"), "The url of the request must contain the name")
    }
    
    func test_GetSessionSeries_WhenCalledWithRandomCharacter_ReturnsNotNilObject() {
        // Given
        let character = TestingModels.getCharactersTesting()[0].character
        // When
        let sessionSeries = NetworkHelper.getSessionSeries(forCharacter: character)
        // Then
        XCTAssertNotNil(sessionSeries, "GetSessionSeries() must return a not nil URLRequest")
    }
    
    func test_GetSessionSeries_WhenCalledWithRandomCharacter_SessionContainsRawServerPlusEndpointURL() {
        // Given
        let character = TestingModels.getCharactersTesting()[0].character
        // When
        let sessionSeries = NetworkHelper.getSessionSeries(forCharacter: TestingModels.getCharactersTesting()[0].character)
        // Then
        XCTAssertTrue(sessionSeries!.url!.absoluteString.contains("https://gateway.marvel.com/v1/public/characters/\(character.id)/series"), "The url of the request must contain the endpoint")
    }
    
    func test_GenerateFilterUsing_WhenCalledWithoutParameters_ReturnsEmptyArray() {
        // Given
        // When
        let array = NetworkHelper.generateFilterUsing()
        // Then
        XCTAssertEqual(array.count, 0, "GenerateFilterUsing must return an empty array if called without parameters")
    }
    
    func test_GenerateFilterUsing_WhenCalledWithParameters_ParametersMatch() {
        // Given
        // When
        let array = NetworkHelper.generateFilterUsing(name: "1", nameStartsWith: "2", resultsLimit: 3, skipResults: 4)
        // Then
        XCTAssertEqual(array[0].value, "1", "GenerateFilterUsing must return an array with matching parameters")
        XCTAssertEqual(array[1].value, "2", "GenerateFilterUsing must return an array with matching parameters")
        XCTAssertEqual(array[2].value, "3", "GenerateFilterUsing must return an array with matching parameters")
        XCTAssertEqual(array[3].value, "4", "GenerateFilterUsing must return an array with matching parameters")
    }
}
