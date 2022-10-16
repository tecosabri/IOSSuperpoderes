//
//  ImageLoader.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 14/10/22.
//


import UIKit
import Combine


/// Loads images into its `image` property.
class ImageLoader: ObservableObject {
    
    /// The loaded image.
    @Published var image: UIImage? = nil
    /// Indicates if the image loader is still loading the image.
    @Published var isLoading: Bool = false
    
    /// The URL from where the image will be fetched.
    let url: String?
    /// The suscriptors of the publishers to which the image loader has been suscribed.
    private var suscriptors = Set<AnyCancellable>()
    
    /// Image loader initializer that assigns the URL from where the image will be fetched.
    /// - Parameter url:The URL from where the image will be fetched.
    init(url: String?) {
        self.url = url
    }
    
    
    /// Fetches the image contained by the `url` property.
    func fetch() {
        
        // If the image has been loaded it's not needed to refetch
        guard image == nil && !isLoading else { return }
        
        isLoading = true

        guard let url,
              let fetchURL = URL(string: url) else { return }
        
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
                case .failure(_): break
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.image = UIImage(data: data)
            }
            .store(in: &suscriptors)
    }
    
    
    
    
    
}
