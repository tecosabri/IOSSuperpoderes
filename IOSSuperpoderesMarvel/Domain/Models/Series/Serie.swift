//
//  Serie.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation

/// A Marvel character's serie identified by an id.
struct Serie: Codable, Identifiable {
    /// The serie's id.
    let id: Int
    /// The serie's title.
    let title: String
    /// The serie's description.
    let description: String?
    /// The serie's thumbnail.
    var thumbnail: Thumbnail
}
