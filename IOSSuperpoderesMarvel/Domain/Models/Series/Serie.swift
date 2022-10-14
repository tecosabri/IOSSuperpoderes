//
//  Serie.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation

struct Serie: Codable, Identifiable { 
    let id: Int
    let title: String
    let description: String?
    var thumbnail: Thumbnail
}
