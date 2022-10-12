//
//  Serie.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

struct SeriesContainer: Codable {
    let available: Int
    let collectionURI: String
    let items: [SeriesItem]
    let returned: Int
}

struct SeriesItem: Codable {
    let resourceURI: String
    let name: String
}
