//
//  CryptholicApp.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct CryptholicApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationViewModel())
                .environmentObject(AuthenticationViewModel())
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
}

