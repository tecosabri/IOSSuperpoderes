//
//  RootViewModel.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation
import Combine


/// A root view model which will be shared by all the views of the app as an environment object.
final class RootViewModel: ObservableObject {
    /// The status of the root view model with .none default value.
    @Published var status = SceneStatus.none
    
}
