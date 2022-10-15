//
//  CachedAsyncImage.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 14/10/22.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    @StateObject var imageLoader: ImageLoader
    
    init(url: String?) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!) // force unwrap as previously checked
                    .resizable()
                    .frame(width: 250, height: 250)
                    .scaledToFill()
                    .clipped()
            } else if imageLoader.errorMessage != nil {
//                Text(imageLoader.errorMessage!)
//                    .foregroundColor(.red)
//                    .frame(width: 250, height: 250)

            } else {
                // Placeholder
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .border(.gray, width: 4)
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .opacity(1)
                    Image(systemName: "photo")
                        .opacity(0.8)
                        .frame(width: 250, height: 250)
                        .scaledToFill()
                }
            }
        }
        .onAppear() {
            imageLoader.fetch()
        }
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(url: "https://i.annihil.us/u/prod/marvel/i/mg/3/b0/5a84b58724b37/clean.jpg")
    }
}
