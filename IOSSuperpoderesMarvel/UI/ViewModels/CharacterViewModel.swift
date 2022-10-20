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
    
    /// The network fetcher.
    let networkFetching: NetworkFetching
    /// The suscriptors that suscribed to publishers in the character view model.
    private var suscriptors = Set<AnyCancellable>()
    /// The character of the character view model.
    var character: Character
    
    
    /// This initializer assigns the series and the images to a character.
    /// - Parameters:
    ///   - testing: True if the series will be UI tested with false default value.
    ///   - character: The character of this view model.
    /// - Parameter networkFetching: The network fetcher.
    init(withUITesting testing: Bool = false, fromCharacter character: Character, networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
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
    func getSeries(comp: ((Serie?) -> ())? = nil) {
        // Cancels every suscriptor that is not being used
        cancellAllSuscriptors()
        
        // Assign the received series to the series array
        fetchSeries()
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Error loading series")
                    if let comp { comp(Optional<Serie>.none) }
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { data in
                self.series = data.data.results
                // Remove the series without image
                self.series?.forEach { _ in
                    self.series = self.series?.filter { $0.thumbnail.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/landscape_xlarge.jpg" }
                }
                if let comp, let serie = self.series { comp(serie[0]) }
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

extension CharacterViewModel: SeriesFetching {
    
    /// Fetches all series of a character..
    /// - Returns: A publisher to fetch series  receiving in the main thread.
    func fetchSeries() -> AnyPublisher<SeriesDataWrapper, Error> {
        // Get the request for the series
        let urlRequest = NetworkHelper.getSessionSeries(forCharacter: self.character)
        return networkFetching.load(urlRequest!)
            .decode(type: SeriesDataWrapper.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
