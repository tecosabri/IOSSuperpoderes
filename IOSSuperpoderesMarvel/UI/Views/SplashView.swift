//
//  SplashView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 16/10/22.
//

import SwiftUI

struct SplashView: View {
    
    @State var changeOpacity: Bool = false
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            
            Image("marvelLogo")
                .resizable()
                .scaledToFit()
                .opacity(changeOpacity ? 1 : 0)
                .onAppear() {
                    withAnimation(.linear(duration: 3)) {
                        changeOpacity.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        rootViewModel.status = .loaded
                    }
                }
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
