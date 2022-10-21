//
//  CharacterDetail.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 14/10/22.
//

import SwiftUI

struct CharacterDetail: View {
    
    var characterViewModel: CharacterViewModel
    
    var body: some View {
        
        VStack {
            
            if let stringImage = characterViewModel.character.thumbnail.portraitIncredible {
                
                let url = URL(string: stringImage)
                
                AsyncImage(url: url) { image in
                    ZStack(alignment: .top) {
                        
                        Text(characterViewModel.character.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .zIndex(1)
                            .padding()
                        if let image = characterViewModel.imagePortrait {
                            Image(uiImage: image)
                                .resizable()
                            Rectangle()
                                .fill(LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .center))
                                .frame(width: UIScreen.screenWidth)
                                .opacity(0.3)
                        }
                    }
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .border(.gray, width: 4)
                            .scaledToFill()
                            .opacity(1)
                        Image(systemName: "photo")
                            .opacity(0.8)
                            .scaledToFill()
                    }
                }
            }
            
            ScrollView(.horizontal){
                HStack {
                    if let series = characterViewModel.series {
                        ForEach(series) { serie in
                            NavigationLink {
                                SerieDetailView(serie: serie)
                            } label: {
                                SerieRowView(serie: serie)
                            }
                        }
                    }
                }
            }
            .frame(width: UIScreen.screenWidth, height: 150)
        }
    }
}

//struct CharacterDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        var captainAmerica = Character(
//            id: 1009220,
//            name: "Captain America",
//            description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.",
//            modified: "2020-04-04T19:01:59-0400",
//            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg"),
//            series: SeriesContainer(
//                available: 2,
//                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009220/series",
//                items: [
//                    SeriesItem(
//                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
//                        name: "A+X (2012 - 2014)"),
//                    SeriesItem(
//                        resourceURI: "http://gateway.marvel.com/v1/public/series/3620",
//                        name: "A-Next (1998 - 1999)")],
//                returned: 2))
//        captainAmerica.thumbnail.portraitIncredible = "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087/portrait_incredible.jpg"
//        
//        return CharacterDetail(characterViewModel: CharacterViewModel(fromCharacter: captainAmerica))
//    }
//}


