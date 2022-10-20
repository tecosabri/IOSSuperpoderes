//
//  NetworkFetching.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Foundation
import Combine

protocol NetworkFetching {

    func load(_ request: URLRequest) -> AnyPublisher<Data, Error>
}
