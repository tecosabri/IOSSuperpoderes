//
//  Character.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let name, description: String
    let modified: String
    var thumbnail: Thumbnail
    let resourceURI: String
    let series: SeriesContainer
}
