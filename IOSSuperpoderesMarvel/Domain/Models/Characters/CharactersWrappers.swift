//
//  DataClass.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation


struct CharactersDataWrapper: Codable {
    let data: CharactersDataContainer
}

struct CharactersDataContainer: Codable {
    let results: [Character]
}
