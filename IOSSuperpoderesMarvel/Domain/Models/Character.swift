//
//  Character.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

struct CharacterFilter: Encodable {
    let filter: String
}

struct Character: Codable, Identifiable {
    let id: Int
    let name, description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let series: Serie
//    let urls: [URLElement]
}
