//
//  CharactersViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation
import Combine


/// A view model to manage Marvel characters.,
final class CharactersViewModel: ObservableObject {
    
    /// The Marvel characters.
    @Published var characters: [CharacterViewModel]? = []
    /// The status of the view model with .none dafault value.
    @Published var status = SceneStatus.none
    
    /// The limit of characters per request is 10 by default
    let requestLimit: Int = 4
    /// The suscriptors that suscribed to publishers in the characters view model.
    private var suscriptors = Set<AnyCancellable>()
    
    
    ///  The initializer of the characters view model used to test UI.
    /// - Parameter testing: True if this view model will be tested in the UI preview.
    init(withUITesting testing: Bool = false) {
        if testing { characters = TestingModels.getCharactersTesting() }
    }
    
    /// Cancells all suscriptors in the characters view model.
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    
    /// Gets desired characters filtered by the filter parameter.
    ///
    /// This function cancells all prexistent suscriptors to avoid populating the suscriptors array unnecessarily.
    /// - Parameter filter: The filter of the request with nil default value.
    func getCharacters(filter: [Parameter]? = nil) {
        
        status = .loading
        // Cancels every suscriptor that is not being used
        cancellAllSuscriptors()
        
        // Get the request for characters depending on if it will be filtered or return all characters
        guard let urlRequest = NetworkHelper.getSessionCharacters(filter: filter) else { return }
        
        // Assign the received characters to the characters array
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: CharactersDataWrapper.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    self.status = .loaded
                case .failure(let error):
                    print(String(describing: error))
                    self.status = .error(error: "Error loading characters")
                }
            } receiveValue: { data in
                let apiCharactersResponse = data.data.results
                apiCharactersResponse.forEach { character in
                    let characterViewModel = CharacterViewModel(fromCharacter: character)
                    // Avoid duplicates in the array characters as well as characters with no picture
                    if !(self.characters?.contains(characterViewModel) ?? true) &&
                        character.thumbnail.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/landscape_xlarge.jpg" {
                        self.characters?.append(characterViewModel)
                    }
                }
            }
            .store(in: &suscriptors)
    }
    
    
    /// Update the characters array depending on the `searchText` parameter.
    /// - Parameter searchText: The text that will filter the request to get the characters from the API.
    func onChangeSearchText(searchText: String) {
        if !searchText.isEmpty {
            getCharacters(filter: NetworkHelper.generateFilterUsing(nameStartsWith: searchText, resultsLimit: requestLimit)) }
        if searchText.isEmpty { characters = [] }
    }
}


