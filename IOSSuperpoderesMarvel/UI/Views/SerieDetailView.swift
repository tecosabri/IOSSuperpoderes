//
//  SeriesView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct SerieDetailView: View {
    
    var serie: Serie
    
    var body: some View {
        ZStack(alignment: .bottom) {
            let urlString = serie.thumbnail.portraitIncredible ?? ""
            let url = URL(string: urlString)
            AsyncImage(url: url) { image in
                ZStack(alignment: .top) {
                    
                    Text(serie.title)
                        .font(.title)
                        .foregroundColor(.white)
                        .zIndex(1)
                        .padding()
                    
                    image
                        .resizable()
                        .opacity(0.7)
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .center))
                        .frame(width: UIScreen.screenWidth)
                        .opacity(0.3)
                }
                .overlay(textOverlay, alignment: .bottom)
                
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
    }
    
    private var textOverlay: some View {
        VStack {
            if let description = serie.description {
                Text(description)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.screenWidth)
                    .background(.black.opacity(0.6))
            }
        }
    }
}

struct SerieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        var newWolverine = Serie(
            id: 22728,
            title: "All-New Wolverine Vol. 5: Orphans of X (2018)",
            description: "Daken has been kidnapped, and it's up to Wolverine to find him. But when his trail brings her back to the Facility, the place that tortured and created her, what new horrors will Laura find cooking there? Who, exactly, are the Orphans of X? How are they connected to the Wolverine? And what do they know about Laura and her past?",
            thumbnail: Thumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/b0/5a84b58724b37/clean.jpg"))
        newWolverine.thumbnail.portraitIncredible = "https://i.annihil.us/u/prod/marvel/i/mg/3/b0/5a84b58724b37/clean/portrait_incredible.jpg"
        
        return SerieDetailView(serie: newWolverine)
        
    }
}
