//
//  SplashView.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 21/10/22.
//

import XCTest
import SwiftUI
import Combine
import ViewInspector
@testable import IOSSuperpoderesMarvel

extension SplashView: Inspectable {}

final class SplashViewTests: XCTestCase {
    
    func test_MarvelImage_WhenViewAppears_ImageExists() throws {
        // Given
        let splashView = SplashView().environmentObject(RootViewModel())
        let numViews = try splashView.inspect().count
        // When appears
        // Then
        XCTAssertEqual(numViews, 1)
    }
    
    func test_MarvelImage_OnInit_ImageAlphaIs0() throws {
        // Given
        let splashView = SplashView().environmentObject(RootViewModel())
        let image = try splashView.inspect().find(viewWithId: 0)
        // When appears
        // Then
        let imageAlpha = try image.opacity()
        XCTAssertEqual(imageAlpha, 0)
    }
}

