//
//  ContentView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        if authVM.userSession == nil {
            SignIn()
                .transition(AnyTransition.opacity.animation(.easeInOut))
                .if(navVM.darkModeEnabled) { $0.preferredColorScheme(.dark) }
        } else {
            if navVM.onboarding {
                OnboardingView()
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .if(navVM.darkModeEnabled) { $0.preferredColorScheme(.dark) }
            } else {
                TabManager()
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .if(navVM.darkModeEnabled) { $0.preferredColorScheme(.dark) }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
