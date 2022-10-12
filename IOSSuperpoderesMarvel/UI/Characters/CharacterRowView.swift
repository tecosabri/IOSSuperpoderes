//
//  CharacterRowView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {

        
        ZStackLayout(alignment: .top) {
            let imageURL = URL(string: character.thumbnail.path)
            
            Text(character.name)
                .frame(width: 220, height: 80, alignment: .top)
                .lineLimit(2)
                .font(.title3)
                .foregroundColor(.white)
                .padding(5)
                .zIndex(1)
            
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(30)
                    
            } placeholder: {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .shadow(radius: 30)
            }
            
            Rectangle()
                .fill(LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .center))
                .opacity(0.3)
                .frame(width: 250, height: 250)
                .cornerRadius(30)
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
        
        CharacterRowView(character: captainAmerica)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/250.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/250.0/*@END_MENU_TOKEN@*/))
            
    }
}