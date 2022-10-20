//
//  IOSSuperpoderesMarvelTests.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import XCTest
@testable import IOSSuperpoderesMarvel

final class IOSSuperpoderesMarvelTests: XCTestCase {
    
    func test_MD5_WhenCalled_Returns32characterLongString() {
        // Given
        // When
        let randomString = "RandomString"
        // Then
        XCTAssertEqual(randomString.MD5.count, 32)
    }
    
    func test_MD5_whenCalledOnTwoIdenticalStrings_ReturnsSameResult() {
        // Given
        let string1 = "string"
        let string2 = "string"
        // When
        let md5String1 = string1.MD5
        let md5String2 = string2.MD5
        // Then
        XCTAssertEqual(md5String1, md5String2)
    }
}
