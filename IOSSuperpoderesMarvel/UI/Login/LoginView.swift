//
//  LoginView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @StateObject var charactersViewModel: CharactersViewModel
    
    var body: some View {
        VStack {
            if let characters = charactersViewModel.characters {
                let url = URL(string: characters[1].thumbnail.path)
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(height: 300)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(height: 300)
                }
                Text(characters[1].name)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(charactersViewModel: CharactersViewModel())
            .environment(\.locale, .init(identifier: "es"))

        LoginView(charactersViewModel: CharactersViewModel())
            .environment(\.locale, .init(identifier: "en"))
    }
}

