//
//  SplashView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 16/10/22.
//

import SwiftUI

struct SplashView: View {
    
    @State var opacity: Double = 1
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            
            Image("marvelLogo")
                .resizable()
                .scaledToFit()
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        rootViewModel.status = .loaded
                    }
                }
            
            //
            //            Rectangle()
            //                .fill(.white)
            //                .scaledToFit()
            //                .opacity(opacity)
            //                .transition(.opacity)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

extension AnyTransition {
    static func opacityAndScale() -> AnyTransition {
        AnyTransition.opacity.combined(with: .scale)
    }
}
