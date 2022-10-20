//
//  SeriesFetching.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 20/10/22.
//

import Combine

protocol SeriesFetching {
    
    /// Fetches all series of a character..
    /// - Returns: A publisher to fetch series.
    func fetchSeries() -> AnyPublisher<SeriesDataWrapper, Error>
}
