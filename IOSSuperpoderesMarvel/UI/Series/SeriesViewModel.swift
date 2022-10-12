//
//  SeriesViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import Foundation
import Combine

protocol SeriesViewModelProtocol: AnyObject {
    
}

final class SeriesViewModel: ObservableObject {
    
    @Published var series: [Serie]?
    @Published var status = Status.none
    
    private var suscriptors = Set<AnyCancellable>()
    
    private let character: Character
    
    init(fromCharacter character: Character) {
        self.character = character
        getSeries()
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
}
