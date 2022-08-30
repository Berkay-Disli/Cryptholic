//
//  SignUp.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            // logo
            VStack(spacing: 0) {
                Image(colorScheme == .dark ?  "logoFinalBlack":"logoFinal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
            }
            .padding(.vertical)
            
            // header
            VStack(alignment: .leading){
                Text("Hello \(name)")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color("black"))
                    .animation(.easeInOut(duration: 0.23))
                Text("Welcome to Cryptholic!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal])
            
            // Inputs
            VStack {
                CustomInputView(imageName: "person", placeholder: "name", autoCapitalisation: true, text: $name)
                    .padding([.horizontal, .bottom])
                CustomInputView(imageName: "envelope", placeholder: "email", autoCapitalisation: false, text: $email)
                    .padding([.horizontal, .vertical])
                CustomPasswordField(imageName: "lock", placeholder: "password", text: $password)
                    .padding([.horizontal, .top])
            }
            .padding()
            
            VStack {
                Button {
                    if !name.isEmpty && !email.isEmpty && !password.isEmpty {
                        authVM.setTempUsernme(username: name)
                        authVM.firebaseSignUpUsed = true
                        authVM.createAccount(name: name, email: email, password: password)
                    }
                } label: {
                    BigButton(title: "Sign Up", bgColor: Color("bigButtonBlack"), textColor: Color("white"))
                        .padding()
                }
                .alert(authVM.alertMessage, isPresented: $authVM.showAlert) {}
                
                Button {
                    authVM.signInWithCredential()
                } label: {
                    BigSymbolButton(title: "Sign Up With Google", bgColor: colorScheme == .dark ? .gray.opacity(0.7):.gray.opacity(0.3), textColor: Color("black"), image: "google")
                        .padding(.horizontal)
                }
                .alert(authVM.alertMessage, isPresented: $authVM.showAlert) {}

                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                        Text("Sign In.")
                            .fontWeight(.medium)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                }
            }
            .padding(.bottom)
            .navigationBarBackButtonHidden()
            
        }
        .background(Color("bg"))
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
            .environmentObject(AuthenticationViewModel())
    }
}
