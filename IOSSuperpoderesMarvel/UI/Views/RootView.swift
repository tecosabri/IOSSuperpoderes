//
//  RootView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 12/10/22.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        switch rootViewModel.status {
        case .none:
            SplashView()
                .id("SplashView")
                
        default:
            CharactersView(charactersViewModel: CharactersViewModel())
                .id("CharactersView")
        }
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//            .environmentObject(RootViewModel())
//    }
//}
