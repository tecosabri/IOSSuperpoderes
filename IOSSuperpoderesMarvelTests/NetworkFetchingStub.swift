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

    init(returning result: Result<Data, Error>) {
        self.result = result
    }

    func load(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        return result.publisher
//            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
