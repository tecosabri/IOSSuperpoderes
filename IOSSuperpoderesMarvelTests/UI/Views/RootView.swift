//
//  RootView.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 21/10/22.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import IOSSuperpoderesMarvel

extension RootView: Inspectable {}

final class RootViewTests: XCTestCase {

    func test_RootView_WhenStatusIsNone_InstantiatesSplashView() throws {
        // Given
        let rootViewModel = RootViewModel()
        let sut = RootView().environmentObject(rootViewModel)
        // When
        rootViewModel.status = .none
        // Then
        let splashView = try sut.inspect().find(viewWithId: "SplashView")
        XCTAssertNotNil(splashView)
    }
    
    func test_RootView_WhenStatusIsOtherThanNone_InstantiatesCharactersView() throws {
        // Given
        let rootViewModel = RootViewModel()
        let sut = RootView().environmentObject(rootViewModel)
        // When
        rootViewModel.status = .loaded
        // Then
        let charactersView = try sut.inspect().find(viewWithId: "CharactersView")
        XCTAssertNotNil(charactersView)
    }

}
