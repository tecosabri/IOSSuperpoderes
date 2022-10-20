//
//  NetworkFetching.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Foundation
import Combine

protocol NetworkFetching {
    
    /// /// Creates a publisher with types Data and Error treating the httpurl errors.
    /// - Parameter request: The fetch request.
    /// - Returns: A  <Data, Error>  without HTTPUrl errors.
    func load(_ request: URLRequest) -> AnyPublisher<Data, Error>
}
