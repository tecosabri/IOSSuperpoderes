//
//  SerieRowView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct SerieRowView: View {
    
    var serie: Serie
    
    var body: some View {
        VStack {
            let imageURL = URL(string: serie.thumbnail.path)
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                
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
}

//struct SerieRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        let newWolverine = Serie(
//            id: 22728,
//            title: "All-New Wolverine Vol. 5: Orphans of X (2018)",
//            description: "Daken has been kidnapped, and it's up to Wolverine to find him. But when his trail brings her back to the Facility, the place that tortured and created her, what new horrors will Laura find cooking there? Who, exactly, are the Orphans of X? How are they connected to the Wolverine? And what do they know about Laura and her past?",
//            thumbnail: Thumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/b0/5a84b58724b37/clean.jpg"))
//        
//        SerieRowView(serie: newWolverine)
//            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/250.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/250.0/*@END_MENU_TOKEN@*/))
//    }
//}
