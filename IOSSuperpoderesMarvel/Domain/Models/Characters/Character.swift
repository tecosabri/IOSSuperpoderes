//
//  Character.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

/// A Marvel character identified by an id.
struct Character: Codable, Identifiable {
    /// The character's id.
    let id: Int
    /// The character's name.
    let name: String
    /// The character's description.
    let description: String
    /// The character''s last modification date.
    let modified: String
    /// The character's thumbnail.
    var thumbnail: Thumbnail
    /// The character's resourceURL.
    let resourceURI: String
    /// The container of a character containing his series.
    let series: SeriesContainer
}
