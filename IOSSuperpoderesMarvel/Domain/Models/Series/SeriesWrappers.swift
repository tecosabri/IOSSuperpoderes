//
//  SeriesWrappers.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation

struct SeriesDataWrapper: Codable {
    let data: SeriesDataContainer
}

struct SeriesDataContainer: Codable {
    let results: [Serie]
}
