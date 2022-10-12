//
//  LoginView.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation
import SwiftUI

struct LoginView: View {
        
    var body: some View {
        VStack {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.locale, .init(identifier: "es"))

        LoginView()
            .environment(\.locale, .init(identifier: "en"))
    }
}

