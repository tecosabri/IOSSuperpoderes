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
    
    @Published var characters: [CharacterViewModel]? = []
    @Published var status = SceneStatus.none
    
    private var suscriptors = Set<AnyCancellable>()
    
    init(withUITesting testing: Bool = false) {
        testing ? getCharactersTesting() : getCharacters()
    }
    
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    
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
                apiCharactersResponse.forEach { self.characters?.append(CharacterViewModel(fromCharacter: $0)) }
                print("received value")
            }
            .store(in: &suscriptors)
    }
    
    // MARK: - UITesting functions
    func getCharactersTesting() {
        
        let wolverine = Character(
            id: 1009718,
            name: "Wolverine",
            description: "Born with super-human senses and the power to heal from almost any wound, Wolverine was captured by a secret Canadian organization and given an unbreakable skeleton and claws. Treated like an animal, it took years for him to control himself. Now, he's a premiere member of both the X-Men and the Avengers.",
            modified: "2016-05-02T12:21:44-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf.jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009718",
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009718/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/12429",
                        name: "5 Ronin (2010)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/18142",
                        name: "Amazing X-Men (2013 - 2015)")],
                returned: 2))
        
        let captainAmerica = Character(
            id: 1009220,
            name: "Captain America",
            description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.",
            modified: "2020-04-04T19:01:59-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009220",
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009220/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/3620",
                        name: "A-Next (1998 - 1999)")],
                returned: 2))
        
        let blackWidow = Character(
            id: 1009189,
            name: "Black Widow",
            description: "Like her namesake arachnid, Romanoff is stealthy, precise, and absolutely lethal. She is the Black Widow. Black Widow is a deadly one-woman fighting force. An expert in many forms of martial arts, she is also a skilled gymnast and possesses superhuman strength, speed, agility, and endurance.",
            modified: "2016-01-04T18:09:26-0500",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009189",
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009189/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/6079",
                        name: "Adam: Legend of the Blue Marvel (2008)")],
                returned: 2))
        
        let thor = Character(
            id: 1009664,
            name: "Thor",
            description: "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause.",
            modified: "2020-03-11T10:18:57-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/d/d0/5269657a74350.jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009664",
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009664/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/9790",
                        name: "Age of Heroes (2010)")],
                returned: 2))
        
        self.characters = [CharacterViewModel(fromCharacter: wolverine),
                           CharacterViewModel(fromCharacter: captainAmerica),
                           CharacterViewModel(fromCharacter: blackWidow),
                           CharacterViewModel(fromCharacter: thor)]
    }
}


