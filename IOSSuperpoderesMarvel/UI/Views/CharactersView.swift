//
//  CharactersView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct CharactersView: View {
    
    @ObservedObject var charactersViewModel: CharactersViewModel
    
    @State private var searchBarText: String = ""
    @State private var isEmptyList: Bool = true

    private var characters: [CharacterViewModel]? {
        charactersViewModel.characters
    }
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                List {
                    if let characters {
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
                .navigationTitle("Marvel heros")
                .searchable(text: $searchBarText, prompt: "Search your hero")
                .autocorrectionDisabled()
                .textInputAutocapitalization(TextInputAutocapitalization.never)
                .onChange(of: searchBarText) { name in
                    charactersViewModel.onChangeSearchText(searchText: name)
                }
            }
        }
    }
    
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(charactersViewModel: CharactersViewModel(withUITesting: true))
            .environment(\.locale, .init(identifier: "en"))
    }
}
