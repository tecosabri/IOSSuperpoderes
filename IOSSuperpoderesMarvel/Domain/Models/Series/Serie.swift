//
//  Serie.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation

struct Serie: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}
