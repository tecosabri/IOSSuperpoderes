//
//  Thumbnail.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

struct Thumbnail: Codable {
    var path: String
    var portraitIncredible: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.portraitIncredible = self.path + "/portrait_incredible.jpg"
        self.path += "/standard_xlarge.jpg"
    }
}

extension Thumbnail {
    
    init(path: String) {
        self.path = path
    }
}
