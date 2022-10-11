//
//  IOSSuperpoderesMarvelTests.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import XCTest
@testable import IOSSuperpoderesMarvel

final class IOSSuperpoderesMarvelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testGenerateMD5_whenCalled_returns32characterLongString() {
        // Given
        // When
        guard let md5String = try? AuthenticationHelper.generateMD5() else { return }
        // Then
        XCTAssertEqual(md5String.count, 32)
    }
}
