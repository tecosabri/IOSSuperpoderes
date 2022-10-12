//
//  SeriesView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct SeriesView: View {
    
    @StateObject var seriesViewModel: SeriesViewModel
    @ObservedObject var charactersViewModel: CharactersViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if let series = seriesViewModel.series {
                    ForEach(series) { serie in
                        NavigationLink {
                            // TODO: serie detail
                        } label: {
                            HStack{ // Center view
                                Spacer()
                                SerieRowView(serie: serie)
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

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {

        let wolverine = Character(
            id: 1009718,
            name: "Wolverine",
            description: "Born with super-human senses and the power to heal from almost any wound, Wolverine was captured by a secret Canadian organization and given an unbreakable skeleton and claws. Treated like an animal, it took years for him to control himself. Now, he's a premiere member of both the X-Men and the Avengers.",
            modified: "2016-05-02T12:21:44-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf.jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009718",
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009718/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/12429",
                        name: "5 Ronin (2010)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/18142",
                        name: "Amazing X-Men (2013 - 2015)")],
                returned: 2))
        
        SeriesView(seriesViewModel: SeriesViewModel(withUITesting: true, fromCharacter: wolverine), charactersViewModel: CharactersViewModel(withUITesting: true))
           
    }
}
