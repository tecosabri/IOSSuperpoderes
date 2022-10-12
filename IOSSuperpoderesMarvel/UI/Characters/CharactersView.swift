//
//  CharactersView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject var charactersViewModel: CharactersViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if let characters = charactersViewModel.characters {
                    ForEach(characters) { character in
                        NavigationLink {
                            SeriesView(seriesViewModel: SeriesViewModel(fromCharacter: character), charactersViewModel: charactersViewModel)
                        } label: {
                            HStack{ // Center view
                                Spacer()
                                CharacterRowView(character: character)
                                Spacer()
                            }
                        }
                        .listRowSeparator(.hidden) // Hides separator between characters
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(charactersViewModel: CharactersViewModel(withUITesting: true))
            .environment(\.locale, .init(identifier: "es"))
    }
}
