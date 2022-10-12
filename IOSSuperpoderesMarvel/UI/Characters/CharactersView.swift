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
                            // TODO: Charater detail
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
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(charactersViewModel: CharactersViewModel(withUITesting: true))
            .environment(\.locale, .init(identifier: "es"))
    }
}
