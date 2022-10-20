//
//  CharactersFetching.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Combine

protocol CharactersFetching {
    
    /// Fetches characters.
    /// - Parameter filter: A filter to select certain type of characters.
    /// - Returns: A publisher to fetch characters.
    func fetchCharacters(filter: [Parameter]?) -> AnyPublisher<CharactersDataWrapper, Error>
}
