//
//  CryptholicApp.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI
import Firebase

@main
struct CryptholicApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationViewModel())
                .environmentObject(AuthenticationViewModel())
        }
    }
}
