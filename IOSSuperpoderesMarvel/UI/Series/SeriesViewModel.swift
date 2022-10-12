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
    
    @Published var series: [Character]?
    @Published var status = Status.none
    
    private var suscriptors = Set<AnyCancellable>()
    
    private let character: Character
    
    init(fromCharacter character: Character) {
        self.character = character
        // TODO: Get series
    }
    
    private func cancellAllSuscriptors() {
        suscriptors.forEach { $0.cancel() }
    }
    

}
