//
//  Profile.swift
//  Cryptholic
//
//  Created by Berkay Disli on 8.08.2022.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    var body: some View {
        VStack {
            Spacer()
            Button {
                authVM.signOut()
            } label: {
                BigButton(title: "Sign Out 👋🏻", bgColor: .black, textColor: .white)
                    .padding()
            }
            Spacer()

        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(AuthenticationViewModel())
    }
}
