//
//  SeriesViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import UIKit
import Combine

protocol CharacterViewModelProtocol: AnyObject {
    
}

final class CharacterViewModel: ObservableObject {

    @Published var series: [Serie]?
    @Published var status = SceneStatus.none
    @Published var image: UIImage?
    @Published var imagePortrait: UIImage?
    
    private var suscriptors = Set<AnyCancellable>()
    
    var character: Character
    
    init(withUITesting testing: Bool = false, fromCharacter character: Character) {
        self.character = character
        getSeries()
        downloadImages()
    }
    
    private func downloadImages() {
        // Download square image
        let imageLoader1 = ImageLoader(url: character.thumbnail.path)
        imageLoader1.fetch()
        imageLoader1.$image
            .replaceError(with: UIImage(systemName: "photo"))
            .receive(on: DispatchQueue.main)
            .sink { photo in
                self.image = photo
            }
            .store(in: &suscriptors)
        // Download portrait image
        let imageLoader2 = ImageLoader(url: character.thumbnail.portraitIncredible)
        imageLoader2.fetch()
        imageLoader2.$image
            .replaceError(with: UIImage(systemName: "photo"))
            .receive(on: DispatchQueue.main)
            .sink { photo in
                self.imagePortrait = photo
            }
            .store(in: &suscriptors)
    }
    
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    

    func getSeries() {
        // Cancels every suscriptor that is not being used
        cancellAllSuscriptors()
        
        // Get the request for series of the character
        guard let urlRequest = NetworkHelper.getSessionSeries(forCharacter: character) else { return }
        
        // Assign the received series to the series array
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: SeriesDataWrapper.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Error loading series")
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { data in
                self.series = data.data.results
            }
            .store(in: &suscriptors)
    }
    
    // MARK: - UITesting functions
    func getSeriesTesting() {
        
        let aPlusX = Serie(
            id: 16450,
            title: "A+X (2012 - 2014)",
            description: "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34"))
        
        let newXMen = Serie(
            id: 16449,
            title: "All-New X-Men (2012 - 2015)",
            description: "In the wake of the events of Avengers Vs. X-Men, the mutant world is set to receive a big blast from the past, in the form of the original X-Men! How will the young, unsuspecting mutants from the past - including Jean Grey - react to the conflict and turmoil that has engulfed the world of their future?",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/60/5384e7d05aaee"))
        
        let newWolverine = Serie(
            id: 22728,
            title: "All-New Wolverine Vol. 5: Orphans of X (2018)",
            description: "Daken has been kidnapped, and it's up to Wolverine to find him. But when his trail brings her back to the Facility, the place that tortured and created her, what new horrors will Laura find cooking there? Who, exactly, are the Orphans of X? How are they connected to the Wolverine? And what do they know about Laura and her past?",
            thumbnail: Thumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/b0/5a84b58724b37/clean.jpg"))
        
        
        let wolverineSeries = [aPlusX, newXMen, newWolverine]
        
        self.series = wolverineSeries
    }
}

extension CharacterViewModel: Equatable {
    
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        lhs.character.name == rhs.character.name
    }
}
