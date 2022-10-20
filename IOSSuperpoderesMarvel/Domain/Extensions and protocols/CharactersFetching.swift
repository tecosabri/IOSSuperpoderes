//
//  CharactersFetching.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Combine

protocol CharactersFetching {

    func fetchCharacters(filter: [Parameter]?) -> AnyPublisher<CharactersDataWrapper, Error>
}
