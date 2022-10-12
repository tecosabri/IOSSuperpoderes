//
//  CharactersViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation
import Combine

protocol CharactersViewModelProtocol: AnyObject {
    
}

final class CharactersViewModel: ObservableObject {
    
    @Published var characters: [Character]?
    @Published var status = Status.none
    
    private var suscriptors = Set<AnyCancellable>()
    
    init() {
        getCharacters()
    }
    
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    
    func getCharacters(filter: [Parameter]? = nil) {
        
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
            .decode(type: Welcome.self, decoder: JSONDecoder())
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
                self.characters  = data.data.results
                guard let characters = self.characters else { return }
                characters.forEach { print($0.series.items.first?.resourceURI ?? "\($0.name) has no serie?")}
            }
            .store(in: &suscriptors)
    }
}


