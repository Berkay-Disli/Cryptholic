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
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            // logo
            VStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .colorMultiply(.red)
            }
            .padding(.vertical)
            
            // header
            VStack(alignment: .leading){
                Text("Hello \(name)")
                    .font(.largeTitle)
                    .fontWeight(.medium)
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
                        authVM.createAccount(name: name, email: email, password: password)
                    }
                } label: {
                    BigButton(title: "Sign Up", bgColor: .black, textColor: .white)
                        .padding()
                }
                
                Button {
                    authVM.signUpWithCredential()
                } label: {
                    BigSymbolButton(title: "Sign Up With Google", bgColor: .gray.opacity(0.3), textColor: .black, image: "google")
                        .padding(.horizontal)
                }

                
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
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
            .environmentObject(AuthenticationViewModel())
    }
}
