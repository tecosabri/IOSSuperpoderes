//
//  Thumbnail.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

/// A thumbnail that contains the paths to a photo on the internet.
struct Thumbnail: Codable {
    /// The path to the large landscape photo.
    var path: String // Not a let property to allow testing UI previews
    /// The path to the portrait photo
    var portraitIncredible: String? // Not a let property to allow testing UI previews
    
    /// The initializer for the decoder to decode json API data for a Thumbnail.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)  // Using this raw path without image variants leads to load the full size image
        self.portraitIncredible = self.path + "/portrait_incredible.jpg"  // Portrait incredible is 216x324px
        self.path += "/landscape_xlarge.jpg"  // Landscape xlarge is 270x200px
    }
}

extension Thumbnail {
    /// Thumbnail init used for testing UI previews.
    init(path: String) {
        self.path = path
    }
}
