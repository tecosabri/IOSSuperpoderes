//
//  CharacterRowView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct CharacterRowView: View {
    
    @ObservedObject var characterViewModel: CharacterViewModel
    
    
    var body: some View {
        
        VStack {
            // Photo
            ZStackLayout(alignment: .top) {
                //                let imageURL = URL(string: characterViewModel.character.thumbnail.path)
                
                Text(characterViewModel.character.name)
                    .frame(width: 220, height: 80, alignment: .top)
                    .lineLimit(2)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(5)
                    .zIndex(1)
                
                CachedAsyncImage(url: characterViewModel.character.thumbnail.path)
                
                Rectangle()
                    .fill(LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .center))
                    .frame(width: 250, height: 250)
                    .opacity(0.3)
                
                
                //                AsyncImage(url: imageURL) { image in
                //                    ZStack {
                //                        image
                //                            .resizable()
                //                            .frame(width: 250, height: 250)
                //
                //                        Rectangle()
                //                            .fill(LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .center))
                //                            .opacity(0.3)
                //                            .frame(width: 250, height: 250)
                //                    }
                //                } placeholder: {
                //                    ZStack {
                //                        Rectangle()
                //                            .fill(.white)
                //                            .frame(width: 250, height: 250)
                //                            .border(.gray, width: 4)
                //                            .scaledToFill()
                //                            .opacity(1)
                //                        Image(systemName: "photo")
                //                            .opacity(0.8)
                //                            .scaledToFill()
                //                    }
                //                }
                
                
            }
        }
        .onAppear {
            print(URLCache.shared.memoryCapacity / 1024 / 1024)
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
            print(URLCache.shared.memoryCapacity / 1024 / 1024)
        }
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let captainAmerica = Character(
            id: 1009220,
            name: "Captain America",
            description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.",
            modified: "2020-04-04T19:01:59-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009220",
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009220/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/3620",
                        name: "A-Next (1998 - 1999)")],
                returned: 2))
        
        CharacterRowView(characterViewModel: CharacterViewModel(fromCharacter: captainAmerica))
        
    }
}
