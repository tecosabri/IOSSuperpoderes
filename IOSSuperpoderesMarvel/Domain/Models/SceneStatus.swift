//
//  Status.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation

enum SceneStatus: Equatable {
    case none, loading, loaded, register, error(error: String)
}
