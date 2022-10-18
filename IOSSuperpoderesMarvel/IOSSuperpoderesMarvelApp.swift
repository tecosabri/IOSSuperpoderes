//
//  IOSSuperpoderesMarvelApp.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import SwiftUI

@main
struct IOSSuperpoderesMarvelApp: App {
    
    @StateObject var rootViewModel = RootViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}
