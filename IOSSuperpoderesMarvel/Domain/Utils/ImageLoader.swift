//
//  ImageLoader.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 14/10/22.
//


import UIKit
import Combine


class ImageLoader: ObservableObject {
    
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    let url: String?
    
    private var suscriptors = Set<AnyCancellable>()
    
    init(url: String?) {
        self.url = url
    }
    
    func fetch() {
        
        guard image == nil && !isLoading else { return }
        
        isLoading = true

        guard let url,
              let fetchURL = URL(string: url)
        else {
            errorMessage = URLError(.badServerResponse).localizedDescription
            return
        }
        let urlRequest = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.image = UIImage(data: data)
            }
            .store(in: &suscriptors)
    }
    
    
    
    
    
}
