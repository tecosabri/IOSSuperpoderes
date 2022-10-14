//
//  LoginView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation
import SwiftUI

struct LoadingView: View {
        
    var body: some View {
        VStack {
            Text("Loading")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .environment(\.locale, .init(identifier: "es"))

        LoadingView()
            .environment(\.locale, .init(identifier: "en"))
    }
}

