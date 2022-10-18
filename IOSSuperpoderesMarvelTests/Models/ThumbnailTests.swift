//
//  ThumbnailTests.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 18/10/22.
//

import XCTest
@testable import IOSSuperpoderesMarvel

final class ThumbnailTests: XCTestCase {
    
    let thumbnailJSON = """
            {
                "path": "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                "extension": "jpg"
            }
            """
    
    func test_WhenThumbnailInstantiationFromDecoder_ReturnsObject() {
        // Given
        guard let thumbnailData = thumbnailJSON.data(using: .utf8) else { return }
        let jsonDecoder = JSONDecoder()
        // When
        let thumbnail = try? jsonDecoder.decode(Thumbnail.self, from: thumbnailData)
        // Then
        XCTAssertNotNil(thumbnail, "Thumbnail can't be nil")
    }
    
    func test_WhenThumbnailInstantiated_PathIsLandscapeLarge() {
        // Given
        guard let thumbnailData = thumbnailJSON.data(using: .utf8) else { return }
        let jsonDecoder = JSONDecoder()
        // When
        let notNilThumbnail = try? XCTUnwrap(jsonDecoder.decode(Thumbnail.self, from: thumbnailData), "Thumbnail can't be nil")
        // Then
        XCTAssertEqual(notNilThumbnail!.path, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/landscape_xlarge.jpg")
    }
    
    func test_WhenThumbnailInstantiated_PathIsPortraitIncredible() {
        // Given
        guard let thumbnailData = thumbnailJSON.data(using: .utf8) else { return }
        let jsonDecoder = JSONDecoder()
        // When
        let notNilThumbnail = try? XCTUnwrap(jsonDecoder.decode(Thumbnail.self, from: thumbnailData), "Thumbnail can't be nil")
        // Then
        XCTAssertEqual(notNilThumbnail!.portraitIncredible, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_incredible.jpg")
    }
    
    func test_WhenThumbnailInitialized_ReturnsObject() {
        // Given
        // When
        let thumbnail = Thumbnail(path: "path")
        // Then
        XCTAssertNotNil(thumbnail, "Thumnail can't be nil")
    }
    
}
