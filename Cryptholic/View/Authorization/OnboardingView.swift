//
//  OnboardingView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 29.08.2022.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var navVM: NavigationViewModel
    @EnvironmentObject var authVM: AuthenticationViewModel
    @State private var showText = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color("white").ignoresSafeArea()
            Image(colorScheme == .dark ? "logoFinalBlackRemoved":"logoFinalRemoved")
                .resizable()
                .blur(radius: 70)
                .ignoresSafeArea()
            if showText {
                VStack(alignment: .leading) {
                    Text("Hi \(authVM.firebaseSignUpUsed ? authVM.tempUserName:authVM.userSession?.displayName ?? "User")!")
                    Text("Welcome back.")
                }
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(Color("black"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
            }
            
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.showText.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                navVM.disableOnboarding()
            }
        }
        .onDisappear {
            authVM.setTempUsernme(username: "")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
