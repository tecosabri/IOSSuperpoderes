//
//  CharactersView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct CharactersView: View {
    
    @ObservedObject var charactersViewModel: CharactersViewModel
    
    var body: some View {
        if(charactersViewModel.status == .loaded) {
            NavigationStack {
                List {
                    if let characters = charactersViewModel.characters {
                        ForEach(characters, id: \.character.id) { characterViewModel in
                            NavigationLink {
                                CharacterDetail(characterViewModel: characterViewModel)
                            } label: {
                                HStack{ // Center view
                                    Spacer()
                                    CharacterRowView(characterViewModel: characterViewModel)
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
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(charactersViewModel: CharactersViewModel(withUITesting: true))
            .environment(\.locale, .init(identifier: "es"))
    }
}
