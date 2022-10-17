//
//  DataClass.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation

///  A server data wrapper that contains the server characters data containers.
struct CharactersDataWrapper: Codable {
    
    /// The data response of the server containing characters.
    let data: CharactersDataContainer
}

/// A server characters data container.
struct CharactersDataContainer: Codable {
    
    /// The characters product of a call to the Marvel API.
    let results: [Character]
}
