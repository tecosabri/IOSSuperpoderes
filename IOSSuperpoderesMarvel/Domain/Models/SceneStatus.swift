//
//  Status.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation

/// A status that shows the current state of the scene.
enum SceneStatus: Equatable {
    /// The default status of a scene.
    case none
    /// The status of a scene when loading data.
    case loading
    /// The status of a scene when finished loading data.
    case loaded
    /// The status of a scene that produced an error.
    case error(error: String)
}
