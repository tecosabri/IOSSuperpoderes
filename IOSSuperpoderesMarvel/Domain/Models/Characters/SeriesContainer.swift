//
//  Serie.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

/// The series' container of a character.
struct SeriesContainer: Codable {
    /// The number of total available series in this list. Will always be greater than or equal to the "returned" value.
    let available: Int
    /// The path to the full list of series in this collection.
    let collectionURI: String
    /// The list of returned series in this collection.
    let items: [SeriesItem]
    /// The number of series returned in this collection (up to 20).
    let returned: Int
}

/// A Marvel Serie.
struct SeriesItem: Codable {
    /// The path to the individual series resource.
    let resourceURI: String
    /// The canonical name of the series.
    let name: String
}
