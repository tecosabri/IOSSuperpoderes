//
//  CharactersViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation
import Combine


/// A view model to manage Marvel characters.,
final class CharactersViewModel: ObservableObject{

    /// The Marvel characters.
    @Published var characters: [CharacterViewModel]? = []
    /// The status of the view model with .none dafault value.
    @Published var status = SceneStatus.none
    
    /// The limit of characters per request is 10 by default
    let requestLimit: Int = 4
    /// The network fetcher.
    let networkFetching: NetworkFetching
    /// The suscriptors that suscribed to publishers in the characters view model.
    private var suscriptors = Set<AnyCancellable>()
    
    
    ///  The initializer of the characters view model used to test UI.
    /// - Parameter testing: True if this view model will be tested in the UI preview.
    /// - Parameter networkFetching: The network fetcher.
    init(withUITesting testing: Bool = false, networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
        if testing { characters = TestingModels.getCharactersTesting() }
    }
    
    /// Cancells all suscriptors in the characters view model.
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    
    /// Gets desired characters filtered by the filter parameter. The returned array has no duplicates nor characters without image.
    ///
    /// This function cancells all prexistent suscriptors to avoid populating the suscriptors array unnecessarily.
    /// - Parameter filter: The filter of the request with nil default value.
    /// - Parameter comp: Completion used to make the function testable
    func getCharacters(filter: [Parameter]? = nil, comp: ((Character?) -> ())? = nil) {
        
        status = .loading
        // Cancels every suscriptor that is not being used
        cancellAllSuscriptors()
        
        // Assign the received characters to the characters array. Networkfetching used to make it testable
        fetchCharacters(filter: filter)
            .sink { completion in
                switch completion{
                case .finished:
                    self.status = .loaded
                case .failure(let error):
                    if let comp { comp(Optional<Character>.none)}
                    print(String(describing: error))
                    self.status = .error(error: "Error loading characters")
                }
            } receiveValue: { data in
                let apiCharactersResponse = data.data.results
                var characterViewModels: [CharacterViewModel] = []
                apiCharactersResponse.forEach { characterViewModels.append(CharacterViewModel(fromCharacter: $0)) }
                // Avoid empty image characters
                characterViewModels = characterViewModels.filter { $0.character.thumbnail.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/landscape_xlarge.jpg" }
                // Avoid duplicates
                characterViewModels = characterViewModels.filter { characterViewModels.contains($0) }
                self.characters = characterViewModels.sorted(by: { $0.character.name < $1.character.name })
                if let comp { comp(characterViewModels[0].character)} // To make it testable
            }
            .store(in: &suscriptors)
    }

    /// Update the characters array depending on the `searchText` parameter.
    /// - Parameter searchText: The text that will filter the request to get the characters from the API.
    /// - Parameter comp: Completion used to make the function testable
    func onChangeSearchText(searchText: String, comp: ((Character?) -> ())? = nil) {
        if !searchText.isEmpty { getCharacters(filter: [Parameter(parameterName: .nameStartsWith, value: searchText)], comp: { character in
            if let comp {comp(character)}
        })}
        if searchText.isEmpty { characters = [] }
    }
}

extension CharactersViewModel: CharactersFetching {
    
    /// Creates a publisher to fetch characters from the Marvel API
    /// - Parameter filter: The filter of the request with nil default value.
    /// - Returns: A publisher to fetch characters from the Marvel API
    func fetchCharacters(filter: [Parameter]?) -> AnyPublisher<CharactersDataWrapper, Error> {
        // Get the request for characters
        let urlRequest = NetworkHelper.getSessionCharacters(filter: filter)
        return networkFetching.load(urlRequest!)
            .decode(type: CharactersDataWrapper.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}


