//
//  URLSessionExtension.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Foundation
import Combine

extension URLSession: NetworkFetching {
    
    /// Creates a publisher with types Data and Error treating the httpurl errors.
    /// - Parameter request: The fetch request.
    /// - Returns: A  <Data, Error>  without HTTPUrl errors.
    func load(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        return dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
