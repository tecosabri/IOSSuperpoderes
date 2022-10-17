//
//  SeriesViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import UIKit
import Combine


/// The view model to manage a Marvel character.
final class CharacterViewModel: ObservableObject {
    /// The Marvel series where the character of the character view model appears.
    @Published var series: [Serie]?
    /// The status of the character view model with .none default value.
    @Published var status = SceneStatus.none
    /// The landscape image (270x200px) of the thumbnail that shows the character of the character view model.
    @Published var image: UIImage?
    /// The portrait image (216x324px) of the thumbnail that shows the character of the character view model.
    @Published var imagePortrait: UIImage?
    
    /// The suscriptors that suscribed to publishers in the character view model.
    private var suscriptors = Set<AnyCancellable>()
    /// The character of the character view model.
    var character: Character
    
    
    /// This initializer assigns the series and the images to a character.
    /// - Parameters:
    ///   - testing: True if the series will be UI tested with false default value.
    ///   - character: The character of this view model.
    init(withUITesting testing: Bool = false, fromCharacter character: Character) {
        self.character = character
        if testing { series = TestingModels.getSeriesTesting()}
        else { getSeries() }
        downloadImages()
    }
    
    /// Cancells all suscriptors in the characters view model.
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    
    /// Downloads and assigns the `image` and `imagePortrait` properties.
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
    
    /// Gets all the series where the character of this character view model appears.
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
                // Remove the series without image
                self.series?.forEach { _ in
                    self.series = self.series?.filter { $0.thumbnail.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/landscape_xlarge.jpg" }
                }
            }
            .store(in: &suscriptors)
    }
}

extension CharacterViewModel: Equatable {
    
    /// The equals function returns true if both the characters of the two character view models being compared have the same name.
    /// - Parameters:
    ///   - lhs: One of the character view models being compared.
    ///   - rhs: One of the character view models being compared.
    /// - Returns: True if the name of both names of the  characters in the character view models being compared are the same.
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        lhs.character.name == rhs.character.name
    }
}
