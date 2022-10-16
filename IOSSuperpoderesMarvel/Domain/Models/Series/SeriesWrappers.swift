//
//  SeriesWrappers.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation


///  A server data wrapper that contains the server series containers.
struct SeriesDataWrapper: Codable {
    
    /// The data response of the server containing series.
    let data: SeriesDataContainer
}

/// A server series data container.
struct SeriesDataContainer: Codable {
    
    /// The series product of a call to the Marvel API.
    let results: [Serie]
}
