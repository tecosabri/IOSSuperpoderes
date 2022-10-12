//
//  URLElement.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

struct URLElement: Codable {
    let type: URLType
    let url: String
}

struct URLType: Codable {
    let comiclink: String
    let detail: String
    let wiki: String
}
