//
//  NetworkFetchingStub.swift
//  IOSSuperpoderesMarvelTests
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

@testable import IOSSuperpoderesMarvel
import Combine
import Foundation

class NetworkFetchingStub: NetworkFetching {

    private let result: Result<Data, Error>
    
    // Assign .failure or .success to result leads to the two different cases of the request
    init(returning result: Result<Data, Error>) {
        self.result = result
    }
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        return result.publisher
            .eraseToAnyPublisher()
    }
}
