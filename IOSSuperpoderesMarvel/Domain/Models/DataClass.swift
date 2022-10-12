//
//  DataClass.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation


struct Welcome: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let results: [Character]
}
