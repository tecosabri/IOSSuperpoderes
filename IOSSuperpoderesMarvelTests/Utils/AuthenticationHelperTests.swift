//
//  AuthenticationHelperTests.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 18/10/22.
//

import XCTest
@testable import IOSSuperpoderesMarvel

final class AuthenticationHelperTests: XCTestCase {

    func test_GenerateMD5_WhenCalled_ReturnsATupleOfTwoStrings() {
        // Given
        // When
        guard let tuple = try? AuthenticationHelper.generateMD5() else { return }
        let isMD5Tuple = tuple is (String?, String)
        // Then
        XCTAssertTrue(isMD5Tuple, "The tuple returned by the method must be of type (String?, String)")
    }
    
    func test_GenerateMD5_WhenCalled_ReturnsCurrentTimestamp() {
        // Given
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = format.string(from: date)
        // When
        let sutTimestamp = try? AuthenticationHelper.generateMD5().timeStamp
        // Then
        XCTAssertEqual(timestamp, sutTimestamp, "Timestamps must be the same")
    }

}
